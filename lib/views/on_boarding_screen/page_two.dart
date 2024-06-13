
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';

class Page_Two extends StatelessWidget {
  const Page_Two({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(Maincolor.value),
              image: const DecorationImage(
                  image: AssetImage(''),
                  fit: BoxFit.fill,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(),
            child: Center(child: Image.asset("Assets/Images/p11-removebg.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Center(
                    child: ReusableText(
                      text: 'Fuel Up Securely',
                      fontSize:25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Center(
                    child: ReusableText(
                      text: 'With Our Expertise',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 10,
                ),



              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 30,right: 30,top: 600),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Experience hassle-free fuel delivery and expert vehicle maintenance services wherever you are.\n',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: 'We ensure your vehicle is always ready, so you can focus on your journey.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )
    );
  }
}
