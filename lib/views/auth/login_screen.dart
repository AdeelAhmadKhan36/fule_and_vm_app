import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/controllers/login_provider.dart';
import 'package:fule_and_vm_app/home_screen.dart';
import 'package:fule_and_vm_app/utils/utils.dart';
import 'package:fule_and_vm_app/views/auth/admin_signup.dart';
import 'package:fule_and_vm_app/views/auth/forgot_password.dart';
import 'package:fule_and_vm_app/views/auth/usersignup_screen.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:fule_and_vm_app/widgets/Round_button.dart';
import 'package:fule_and_vm_app/widgets/app.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  String? selectedRole;
  bool _isObscure3 = true;
  bool visible = false;
  bool isLoading = false;
  bool _hasError = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  Future<String> _getDeviceName() async {
    String deviceName = '';
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.name;
      }
    } catch (e) {
      print('Failed to get device name: $e');
    }
    return deviceName;
  }

  Future<String> _getIPAddress() async {
    String ipAddress = '';
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list(
          includeLoopback: false, type: InternetAddressType.IPv4);
      for (NetworkInterface interface in interfaces) {
        for (InternetAddress address in interface.addresses) {
          if (!address.isLoopback) {
            ipAddress = address.address;
            break;
          }
        }
        if (ipAddress.isNotEmpty) {
          break;
        }
      }
    } catch (e) {
      print('Failed to get IP address: $e');
    }
    return ipAddress;
  }

  Future<bool> checkUserExists() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Use the `get` method to check if the document with the specified userId exists
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .get();

        // Return true if the document exists
        return userSnapshot.exists;
      }
      return false;
    } catch (error) {
      // Handle errors, e.g., connection issues, etc.
      print("Error checking user existence: $error");
      return false;
    }
  }

  Future<bool> checkAdminExists() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Use the `get` method to check if the document with the specified adminId exists
        DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
            .collection('Admins')
            .doc(currentUser.uid)
            .get();

        // Return true if the document exists
        return adminSnapshot.exists;
      }
      return false;
    } catch (error) {
      // Handle errors, e.g., connection issues, etc.
      print("Error checking admin existence: $error");
      return false;
    }
  }

// Inside your login method
  Future<void> login() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      )
          .then((value) async {
        String deviceName = await _getDeviceName();
        String ipAddress = await _getIPAddress();
        DateTime loginTime = DateTime.now();
        Map<String, dynamic> loginData = {
          'deviceName': deviceName,
          'ipAddress': ipAddress,
          'loginTime': loginTime,
        };

        String collectionName;
        if (selectedRole == 'Login as User') {
          collectionName = 'Users/${value.user!.uid}/user_logins';
        } else if (selectedRole == 'Login as Admin') {
          collectionName = 'Admins/${value.user!.uid}/admin_logins';
        } else {
          Utils().toastMessage("Role not recognized. Please sign up.");
          return;
        }

        // Check if the document already exists with the same deviceName and ipAddress
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .where('deviceName', isEqualTo: deviceName)
            .where('ipAddress', isEqualTo: ipAddress)
            .get();

        if (querySnapshot.docs.isEmpty) {
          // Add the login data only if no existing document found
          await FirebaseFirestore.instance
              .collection(collectionName)
              .add(loginData);

          // Check if user or admin exists based on the selected role
          if (selectedRole == 'Login as User') {
            bool userExists = await checkUserExists();
            if (userExists) {
              // Move to User Screen

              Utils().toastMessage("Login Successful");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home_Screen()),
              );


            } else {
              Utils().toastMessage("User not found. Please sign up.");
            }
          } else if (selectedRole == 'Login as Admin') {
            bool adminExists = await checkAdminExists();
            if (adminExists) {
              // Move to Admin Screen

              Utils().toastMessage("Login Successful");
            } else {
              Utils().toastMessage("Admin not found. Please sign up.");
            }
          }
        } else {
          // Document with same deviceName and ipAddress already exists
          Utils().toastMessage("You are already logged in from this device.");
        }
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        print(error);
      });
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
          appBar: RoundedAppBar(
            title: Text("App Bar",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(
                    text: 'Welcome Back!',
                    color: Color(kDark.value),
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  ReusableText(
                    text: 'Fill the details to login to your account',
                    color: Color(kDarkGrey.value),
                  ),
                  SizedBox(height: 80),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [

                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(kGrey.value),
                            hintText: 'Username',
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
                              return "Please! Enter Username";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
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
                            if (!RegExp(
                                    r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]")
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure3 = !_isObscure3;
                                });
                              },
                              child: Icon(
                                _isObscure3
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            filled: true,
                            fillColor: Color(kGrey.value),
                            hintText: 'Select Option',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                          readOnly: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Select Role'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedRole = 'Login as User';
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color(kPrimaryColor.value),
                                        ),
                                        child: Text('Login as User',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedRole = 'Login as Admin';
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color(kPrimaryColor.value),
                                        ),
                                        child: Text('Login as Admin',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          controller: TextEditingController(text: selectedRole),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                Get.to(Forgot_PasswordScreen());
                              },
                              child: Text("Forgot Password?")),
                        ),
                        SizedBox(height: 50),
                        RoundButton(
                          title: 'Login',
                          loading: loginNotifier.isLoading,
                          onTap: () async {
                            loginNotifier.isLoading = true;
                            if (_formkey.currentState!.validate()) {
                              await login();
                              loginNotifier.isLoading = false;
                            }
                          },
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  decoration: TextDecoration.underline),
                            ),
                            InkWell(
                              onTap: () {
                                showSignupOptions(context);
                              },
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    color: Color(kblue.value),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
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

void showSignupOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Signup Option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(UserSignUp_Screen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kPrimaryColor.value),
                ),
                child: Text(
                  'Sign Up as User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(AdminSignUp_Screen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(kPrimaryColor.value),
                ),
                child: Text(
                  'Sign Up as Admin',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
