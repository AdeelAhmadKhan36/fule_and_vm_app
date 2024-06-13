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
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No fuel requests found.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

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
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              border: TableBorder.all(color: Colors.grey),
              children: [
                _buildTableRow('Fuel Type', orderData['selectedFuelType']),
                _buildTableRow('Quantity', '${orderData['selectedQuantity']} Liters'),
                _buildTableRow('Date', (orderData['selectedDate'] as Timestamp).toDate().toLocal().toString()),
                _buildTableRow('Time Slot', orderData['selectedTimeSlot']),
                _buildTableRow('Delivery Location', orderData['selectedLocationName']),
                _buildTableRow('Payment Method', orderData['paymentMethod']),
              ],
            ),
          ),
        ),


        Text("Order by User.",style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),

      ],
    );


  }
}
