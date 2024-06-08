import 'package:flutter/material.dart';
// Widget for the order screen
class OrderScreen extends StatelessWidget {
  final String selectedFuelType;
  final int selectedQuantity;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  // final LatLng? selectedLocation;

  const OrderScreen({
    Key? key,
    required this.selectedFuelType,
    required this.selectedQuantity,
    required this.selectedDate,
    required this.selectedTimeSlot,
    // required this.selectedLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Fuel Type: $selectedFuelType'),
            Text('Quantity: $selectedQuantity'),
            Text('Date: ${selectedDate.toString().substring(0, 10)}'),
            Text('Time Slot: $selectedTimeSlot'),
            // if (selectedLocation != null) ...[
            //   SizedBox(height: 16),
            //   Text('Delivery Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}'),
            // ],
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Process cash on delivery
                    Navigator.pop(context);
                    // Additional logic for cash on delivery
                  },
                  child: Text('Cash on Delivery'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Process online payment
                    Navigator.pop(context);
                    // Additional logic for online payment
                  },
                  child: Text('Digital Payment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}