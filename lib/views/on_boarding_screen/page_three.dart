import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/home_screen.dart';
import 'package:fule_and_vm_app/views/auth/login_screen.dart';
import 'package:fule_and_vm_app/views/auth/usersignup_screen.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:fule_and_vm_app/widgets/custom_outline_button.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page_Three extends StatelessWidget {
  const Page_Three({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(kLightBlue.value),
              image: const DecorationImage(
                image: AssetImage('Assets/Images/p2-removebg.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Welcome Message
          Positioned(
            top: 70, // Adjust this value as needed
            left: 50,
            right: 50,
            child: Center(
              child: ReusableText(
                text: 'Welcome to Fuel Delivery and Maintenance App',
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Other Content
          Positioned.fill(
            top: 650, // Adjust this value as needed
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [


                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'We help you get fuel delivered wherever you are, whenever you need it, ensuring your vehicles are always ready to go.\n',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Stay on track with your deliveries.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Custom_Button(
                        onTap:()async{

                          final SharedPreferences prefs=await SharedPreferences.getInstance();
                          await prefs.setBool('entry point', true);

                          Get.to(()=>Login_Screen());
                        },
                        text: 'Login',
                        color: Color(kLight.value),
                        width: 150,
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>UserSignUp_Screen());
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          color: Color(kLight.value),
                          child: Center(
                            child: ReusableText(
                              text: 'SignUp',
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap:(){
                      Get.to(()=>Home_Screen(selectedLocationName: '',));
                    },
                    child: ReusableText(text: 'Continue as a Guest',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
