import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/const.dart';
import 'package:fule_and_vm_app/utils/utils.dart';
import 'package:fule_and_vm_app/views/Admin/service_provider_Profile.dart';
import 'package:fule_and_vm_app/widgets/app.dart';

class OrderScreen extends StatefulWidget {
  final String selectedFuelType;
  final int selectedQuantity;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final String? selectedLocationName;

  const OrderScreen({
    Key? key,
    required this.selectedFuelType,
    required this.selectedQuantity,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.selectedLocationName,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isCashOnDeliverySelected = false;

  Future<List<String>> getServiceProviders() async {
    List<String> locations = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore.collection('Company_Details').get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('location')) {
          String location = data['location'];
          locations.add(location);
        }
      });
    } catch (e) {
      print('Error fetching service providers: $e');
    }
    return locations;
  }

  Future<String?> fetchUserIdByLocation(String location) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Company_Details')
          .where('location', isEqualTo: location)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Assuming the doc ID is the user ID
      }
    } catch (e) {
      print('Error fetching user ID: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: Text(
          "Confirm Your Order",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Table(
                border: TableBorder.all(),
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
                          child: Text(widget.selectedFuelType),
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
                          child: Text('${widget.selectedQuantity} Liters'),
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
                          child: Text('${widget.selectedDate.toString().substring(0, 10)}'),
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
                          child: Text(widget.selectedTimeSlot),
                        ),
                      ),
                    ],
                  ),
                  if (widget.selectedLocationName != null) ...[
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
                            child: Text(widget.selectedLocationName!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCashOnDeliverySelected = !isCashOnDeliverySelected;
                      });
                      print("Selected");
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isCashOnDeliverySelected ? Colors.green : Color(kPrimaryColor.value),
                      minimumSize: Size(180, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cash on Delivery',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Utils().toastMessage("Digital Payment Service Currently Unavailable");
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(kPrimaryColor.value),
                      minimumSize: Size(180, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Digital Payments',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Text(
                'Service Provider Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              FutureBuilder<List<String>>(
                future: getServiceProviders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return DropdownButtonFormField<String>(
                      value: widget.selectedLocationName,
                      items: snapshot.data?.map<DropdownMenuItem<String>>((location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (newValue) async {
                        if (newValue != null) {
                          String? userUid = await fetchUserIdByLocation(newValue);
                          if (userUid != null) {
                            print("Fetched user ID: $userUid");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileDetailsScreen(
                                  selectedFuelType: widget.selectedFuelType,
                                  selectedQuantity: widget.selectedQuantity,
                                  selectedDate: widget.selectedDate,
                                  selectedTimeSlot: widget.selectedTimeSlot,
                                  selectedLocationName: newValue,
                                  paymentMethod: isCashOnDeliverySelected ? 'Cash on Delivery' : 'Digital Payments',
                                  userUid: userUid,
                                ),
                              ),
                            );
                          } else {
                            // Handle error: user ID not found
                            print("User ID not found for location: $newValue");
                          }
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
