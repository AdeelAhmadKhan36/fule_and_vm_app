import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';

class Page_One extends StatelessWidget {
  const Page_One({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(kPrimaryColor.value),
            image: const DecorationImage(
                image: AssetImage('Assets/Images/P1removebg.png'),
                fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150,left: 10),
          child: Column(
            children: [
              Center(
                  child: ReusableText(
                text: 'Reliable Fuel Delivery & Vehicle Maintenance',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 600),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'We help you keep your vehicle running smoothly with our convenient fuel delivery and maintenance services\n',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: ' Enjoy peace of mind knowing that your vehicle is in good hands, wherever you are.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ]),
    );
  }
}
