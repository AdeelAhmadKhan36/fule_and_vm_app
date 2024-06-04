import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/widgets/custom_button.dart';
import 'package:fule_and_vm_app/widgets/custumfield.dart';
import 'package:fule_and_vm_app/widgets/small_button.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Maincolor,
          ),
         const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Login!',
                  style: TextStyle(
                      fontSize: 38,
                      color: Whitecolr,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 70,),
              Custumfield(TextFormFieldvalu: 'Please Enter Your Email',),
              Custumfield(TextFormFieldvalu: "Please enter your pasword"),
              const customButton(
                bottontext: "Login",
                bottoncolr: lightblackcolr,
                bottontextcolr: Whitecolr,
              ),
            ],
          )
        ],
      ),
    );
  }
}
