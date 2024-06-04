import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/widgets/custom_button.dart';
import 'package:fule_and_vm_app/widgets/small_button.dart';
import 'package:get/get.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmallButton(bgcolr: Maincolor,cusicons: Icons.arrow_back, height: 30.0, width: 30.0
          ,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SmallButton(cusicons: Icons.question_mark,bgcolr: Maincolor, height: 40.0, width: 40.0,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: bluecolr, borderRadius: BorderRadius.circular(14)),
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text('Google map')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 150,
                width: Get.width,
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    offset: Offset(1, 2),
                    blurRadius: 5,
                    color: lightblackcolr,
                  )
                ], borderRadius: BorderRadius.circular(14), color: Whitecolr),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Oder details:',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 70,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: lightblackcolr,
                            borderRadius: BorderRadius.circular(13)),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 30,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'jame cory',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Id -ad123',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: SmallButton(
                                  bgcolr: Whitecolr,
                                  cusicons: Icons.phone,
                                  iconcolr: Maincolor,height: 50.0, width: 50.0
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: SmallButton(
                                  bgcolr: Whitecolr,
                                  cusicons: Icons.message,
                                  iconcolr: Maincolor, height: 50.0, width: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 255,
              width: Get.width,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 2),
                  blurRadius: 5,
                  color: lightblackcolr,
                )
              ], borderRadius: BorderRadius.circular(14), color: Whitecolr),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:40,top: 40),
                        child: Column(
                          children: [Text('Your Oder:',style: TextStyle(fontSize: 18),),
                          Icon(Icons.car_crash,size: 60,color: Maincolor,),
                          Text('12 liter pertol',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        
                      ),
                      SizedBox(width: 50,),
                      Padding(
                        padding: const EdgeInsets.only(left:40,top: 40),
                        child: Column(
                          children: [Text('Vender:',style: TextStyle(fontSize: 18),),
                          Icon(Icons.shopping_cart,size: 50,color: Maincolor,),
                          
                          Text('12 liter pertol',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  customButton(bottoncolr: lightblackcolr,bottontext: 'Recived & Pay',bottontextcolr: Maincolor,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
