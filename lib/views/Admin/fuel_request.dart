import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fule_and_vm_app/widgets/app.dart';

class FuelRequestScreen extends StatelessWidget {
  final String currentUid;

  const FuelRequestScreen({Key? key, required this.currentUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: Text(
          "Fuel Request Page",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Admins')
            .doc(currentUid)
            .collection('Order')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No fuel requests found.'),
            );
          }

          // Print the fetched data for debugging
          snapshot.data!.docs.forEach((doc) {
            print('Document data: ${doc.data()}');
          });

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              // Ensure the orderData contains all the required fields
              if (orderData.containsKey('selectedFuelType') &&
                  orderData.containsKey('selectedQuantity') &&
                  orderData.containsKey('selectedDate') &&
                  orderData.containsKey('selectedTimeSlot') &&
                  orderData.containsKey('selectedLocationName') &&
                  orderData.containsKey('paymentMethod')) {
                return _buildFuelRequestCard(orderData);
              } else {
                return ListTile(
                  title: Text('Invalid order data'),
                  subtitle: Text('Some fields are missing in the order data.'),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildFuelRequestCard(Map<String, dynamic> orderData) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fuel Type: ${orderData['selectedFuelType']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Quantity: ${orderData['selectedQuantity']} Liters'),
            Text('Date: ${orderData['selectedDate']}'),
            Text('Time Slot: ${orderData['selectedTimeSlot']}'),
            Text('Delivery Location: ${orderData['selectedLocationName']}'),
            Text('Payment Method: ${orderData['paymentMethod']}'),
          ],
        ),
      ),
    );
  }
}
