import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/auth/login.dart';
import 'package:fule_and_vm_app/auth/sign_up.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/views/my_orderScreen.dart';
import 'package:fule_and_vm_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Maincolor,
            child: Center(
              child: Text('Say Goodbye to a \nfuel station!',style: TextStyle(fontSize: 38,color: Whitecolr,fontWeight: FontWeight.bold),),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customButton(bottontext: "Login", bottoncolr: Whitecolr,bottontextcolr: blackcolr,onpressed:() {Get.to(Login());},),
               customButton(bottontext: "Create Account",bottoncolr: Whitecolr,bottontextcolr: blackcolr, onpressed: (){Get.to(SignUP());}, ),
              const customButton(bottontext: "Contine as guest", bottoncolr: lightblackcolr,bottontextcolr: Whitecolr,),  
            ],
          )
        ],
      ),
    );
  }
}
