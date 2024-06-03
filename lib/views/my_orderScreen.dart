import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fule_and_vm_app/const.dart';
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
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: blackcolr, borderRadius: BorderRadius.circular(14)),
                height: 300,
                width: MediaQuery.of(context).size.width,
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
                        child:  Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Icon(Icons.person, size: 30,),
                              SizedBox(width: 25,),
                              const Column(
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
                              Container()
                              
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
