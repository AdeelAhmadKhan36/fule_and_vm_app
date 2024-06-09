import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/views/common/reuse_able_text.dart';
import 'package:get/get.dart';
class ServiceProviderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: kDarkBlue,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'Assets/Images/dashboard(1).png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Heading(
                                text: 'Welcome to your dashboard',
                                color: kLight,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 10),
                              const Flexible(
                                child: Text(
                                  'This dashboard has been created to help you manage your services efficiently. You can handle fuel delivery, schedule maintenance, and view service analytics.',
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColors,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to Fuel Delivery Requests Screen
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kLightPink,
                                  minimumSize: const Size(100, 100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.indigo,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Heading(
                                      text: '25',
                                      color: kLight,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    Heading(
                                      text: 'Fuel Requests',
                                      color: kLight,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to Maintenance Schedule Screen
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kLightGreen,
                                    minimumSize: const Size(100, 100),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.indigo,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Heading(
                                        text: '40',
                                        color: kLight,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 10),
                                      Heading(
                                        text: 'Maintenance',
                                        color: kLight,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Add Fuel Request Screen
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: kDarkBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Heading(
                                  text: 'Add Fuel Request',
                                  color: kLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Maintenance Analytics Screen
                            },
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: kDarkBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Heading(
                                  text: 'Maintenance Analytics',
                                  color: kLight,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
