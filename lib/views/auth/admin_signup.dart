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




class AdminSignUp_Screen extends StatefulWidget {
  const AdminSignUp_Screen({super.key}); // Corrected the constructor

  @override
  State<AdminSignUp_Screen> createState() => _AdminSignUp_ScreenState();
}

class _AdminSignUp_ScreenState extends State<AdminSignUp_Screen> {
  bool _isObscure3 = true;
  bool _isObscure4 = true;
  bool visible = false;
  bool loading = false;
  bool _hasError = false;
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
  Future<void> StoreAdmin_Data() async{

    final admin = _auth.currentUser;
    if(admin!=null){
      final userData={
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
      };

      await FirebaseFirestore.instance.collection('Admins').doc(admin.uid).set(userData);

    }else{
      print('Error in Collection');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: RoundedAppBar(title: Text("Signup for Admin",style: TextStyle(color: Colors.white),),),
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
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(kGrey.value),
                                    hintText: "Company's Name",
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
                                      return "Company's Name cannot be empty";
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
                                    hintText: "Company's email",
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
                                      return "Company's email cannot be empty";
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
                                    hintText: 'Official Number',
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
                                      return "Official Number cannot be empty";
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
                                  obscureText: _isObscure3,
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
                              ],
                            )),


                        SizedBox(height: 40),
                        RoundButton(
                          title: 'SignUp',
                          loading: signupNotifier.isLoading,
                          onTap: () async{
                            if(_formkey.currentState!.validate()){
                              signupNotifier.isLoading=true;
                              try{
                                await _auth.createUserWithEmailAndPassword(
                                    email:emailController.text.toString(),
                                    password: passwordController.text.toString()

                                );
                                await StoreAdmin_Data();
                                signupNotifier.isLoading = false;
                                Utils().toastMessage("Admin Signup Successfully ");
                                Get.to(Login_Screen());



                              }catch(error){
                                print('Signup error: $error');
                                signupNotifier.isLoading=false;
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
