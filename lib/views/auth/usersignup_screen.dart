import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/controllers/SignUp_Provider.dart';
import 'package:fule_and_vm_app/utils/utils.dart';
import 'package:fule_and_vm_app/views/auth/login_screen.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:fule_and_vm_app/widgets/Round_button.dart';
import 'package:fule_and_vm_app/widgets/app.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserSignUp_Screen extends StatefulWidget {
  const UserSignUp_Screen({super.key}); // Corrected the constructor

  @override
  State<UserSignUp_Screen> createState() => _UserSignUp_ScreenState();
}

class _UserSignUp_ScreenState extends State<UserSignUp_Screen> {
  bool _isObscure3 = true;
  bool _isObscure4 = true;
  bool visible = false;
  bool isLoading = false;
  bool _hasError = false;
  bool _isPasswordField = true;


  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ConfirmpasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController=TextEditingController();


  FirebaseAuth _auth=FirebaseAuth.instance;

  // Corrected the method override with @override
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> _signUpAndStoreUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
        // Add other fields as needed
      };

      // Use FirebaseFirestore.instance if you're using the latest version of cloud_firestore
      // Import FirebaseFirestore if needed
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set(userData);
    }else{

      print("Error in Collection");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar:RoundedAppBar(title: Text("SignUp"),),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(
                    text: 'Welcome to My App',
                    color: Color(kDark.value),
              
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  ReusableText(
                    text: 'Fill the details to create your account', // Corrected the text
                    color: Color(kDarkGrey.value),
                  ),
                  SizedBox(height: 20),
                  Container(
                    // Adjust width as needed
                    child: Column(
                      children: [
                        Form(
                          key: _formkey ,
                            child:Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(kGrey.value),
                                    hintText: 'User Name',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "User Name cannot be empty";
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 40),

                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(kGrey.value),
                                    hintText: 'Email',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email cannot be empty";
                                    }
                                    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]")
                                        .hasMatch(value)) {
                                      return "Please enter a valid email";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 40),

                                TextFormField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(kGrey.value),
                                    hintText: 'Phone Number',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Phone Number cannot be empty";
                                    }
                                    // Add more validation if needed
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: 40),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: _isObscure3,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _isObscure3=signupNotifier.isPasswordObscure;
                                        signupNotifier.isPasswordObscure = !signupNotifier.isPasswordObscure;
                                      },
                                      child: Icon(
                                        signupNotifier.isPasswordObscure ? Icons.visibility : Icons.visibility_off,
                                      ),
                                    ),

                                    filled: true,
                                    fillColor: Color(kGrey.value),
                                    hintText: 'Password',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    final regex = RegExp(r'^.{6,}$');
                                    if (value!.isEmpty) {
                                      return "Password cannot be empty";
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return "Please enter a valid password (min. 6 characters)";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 40),
                                //Confirm Password
                                TextFormField(
                                  controller: ConfirmpasswordController,
                                  obscureText: _isObscure4,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _isObscure4=signupNotifier.isConfirmPasswordObscure;
                                        signupNotifier.isConfirmPasswordObscure = !signupNotifier.isConfirmPasswordObscure;
                                      },
                                      child: Icon(
                                        signupNotifier.isConfirmPasswordObscure ? Icons.visibility : Icons.visibility_off,
                                      ),
                                    ),

                                    filled: true,
                                    fillColor: Color(kGrey.value),
                                    hintText: ' Confirm Password',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value != passwordController.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                                // SizedBox(height: 40),
                                //Select Option


                              ],
                            ) ),
                        

                        SizedBox(height: 40),
                        RoundButton(
                          title: 'SignUp',
                          loading: signupNotifier.isLoading,
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              signupNotifier.isLoading = true;

                              try {
                                // Perform your signup logic here
                                await _auth.createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString(),
                                );

                                // Store user data in Firestore
                                await _signUpAndStoreUserData();

                                // Set isLoading to false when signup and data storage are successful
                                signupNotifier.isLoading = false;

                                Utils().toastMessage(" User Signup Successfully ");
                                Get.to(Login_Screen());
                              } catch (error) {
                                // Handle signup failure, if needed
                                print('Signup error: $error');

                                // Set isLoading to false in case of an error
                                signupNotifier.isLoading = false;

                                Utils().toastMessage(error.toString());
                              }
                            }
                          },
                        ),


                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Already have an account "),
                            InkWell(
                              onTap: () {
                                Get.off(Login_Screen());
                              },
                              child: Text('Login', style: TextStyle(color: Color(kblue.value)),
                              ),
                            ),
                          ],
                        )],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
