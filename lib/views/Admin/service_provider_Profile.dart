import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/home_screen.dart';
import 'package:fule_and_vm_app/widgets/Round_button.dart';
import 'package:fule_and_vm_app/widgets/app.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final String selectedFuelType;
  final int selectedQuantity;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final String? selectedLocationName;
  final String paymentMethod;
  final String userUid;

  const ProfileDetailsScreen({
    Key? key,
    required this.selectedFuelType,
    required this.selectedQuantity,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.selectedLocationName,
    required this.paymentMethod,
    required this.userUid,
  }) : super(key: key);

  Future<Map<String, dynamic>> fetchAdminDetails() async {
    Map<String, dynamic> adminDetails = {};
    try {
      DocumentSnapshot adminProfileSnapshot = await FirebaseFirestore.instance
          .collection('Admins')
          .doc(userUid)
          .collection('Admin_Profile')
          .doc(userUid)
          .get();

      if (adminProfileSnapshot.exists) {
        adminDetails = adminProfileSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching admin details: $e');
    }
    return adminDetails;
  }

  Future<void> submitOrder(BuildContext context) async {
    // Show circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Perform the order submission
      // Example submission code:
      await FirebaseFirestore.instance
          .collection('Admins')
          .doc(userUid)
          .collection('Order')
          .add({
        'selectedFuelType': selectedFuelType,
        'selectedQuantity': selectedQuantity,
        'selectedDate': selectedDate,
        'selectedTimeSlot': selectedTimeSlot,
        'selectedLocationName': selectedLocationName,
        'paymentMethod': paymentMethod,
      });

      // Hide the circular progress indicator
      Navigator.of(context).pop();

      // Show success toast message
      Utils().toastMessage('Order submitted successfully');
      Get.to(Home_Screen(selectedLocationName: '',));
    } catch (e) {
      // Hide the circular progress indicator
      Navigator.of(context).pop();

      // Show error toast message
      Utils().toastMessage('Failed to submit order: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: Text(
          "Profile Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchAdminDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No admin details found.'));
          } else {
            Map<String, dynamic> adminDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Order Details Table
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Table(
                            border: TableBorder.all(color: Colors.grey),
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Fuel Type'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(selectedFuelType),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Quantity'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('$selectedQuantity Liters'),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Date'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          '${selectedDate.toString().substring(0, 10)}'),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Time Slot'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(selectedTimeSlot),
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedLocationName != null) ...[
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        color: Colors.grey[200],
                                        child: Text('Delivery Location'),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(selectedLocationName!),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    // Admin Details Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              if (adminDetails.containsKey('profileImageUrl'))
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      adminDetails['profileImageUrl']),
                                ),
                              SizedBox(width: 16),
                              Text(
                                adminDetails['name'] ?? 'N/A',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Table(
                            border: TableBorder.all(color: Colors.grey),
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Email'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                          Text(adminDetails['email'] ?? 'N/A'),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Phone'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          adminDetails['User Phone'] ?? 'N/A'),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Service'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          adminDetails['service'] ?? 'N/A'),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      color: Colors.grey[200],
                                      child: Text('Location'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          adminDetails['location'] ?? 'N/A'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RoundButton(
                      title: 'Submit Order',
                      onTap: () {
                        submitOrder(context);
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
