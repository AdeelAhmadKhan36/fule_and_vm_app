import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/widgets/custom_button.dart';
import 'package:fule_and_vm_app/widgets/custumfield.dart';
class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
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
                  'Sign In!',
                  style: TextStyle(
                      fontSize: 38,
                      color: Whitecolr,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 52,),
              Custumfield(TextFormFieldvalu: 'Please Enter Your name',),
              Custumfield(TextFormFieldvalu: 'Please Enter Your Email',),
              Custumfield(TextFormFieldvalu: "Please enter your pasword"),
              const customButton(
                bottontext: "Sign In",
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