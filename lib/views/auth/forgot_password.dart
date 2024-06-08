import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/utils/utils.dart';
import 'package:fule_and_vm_app/widgets/Round_button.dart';


class Forgot_PasswordScreen extends StatefulWidget {
  const Forgot_PasswordScreen({super.key});

  @override
  State<Forgot_PasswordScreen> createState() => _Forgot_PasswordScreenState();
}

class _Forgot_PasswordScreenState extends State<Forgot_PasswordScreen> {
  @override
  final _formkey= GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(kPrimaryColor.value),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child:

            Column(children: [
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

                RoundButton(
                  title: 'Forgot Password',
                  onTap: (){
                    _auth.sendPasswordResetEmail(email:emailController.text.toString()).then((value){
                      Utils().toastMessage("We have sent you a email to recore passwords! Please check email");

                    }).onError((error, stackTrace) {
                      
                      Utils().toastMessage(error.toString());
                    });
                    }
                    )
            ],
            )
            )


          ],
        ),
      ),
    );
  }
}
