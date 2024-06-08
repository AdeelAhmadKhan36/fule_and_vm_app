// import 'package:flutter/material.dart';
//
// // Widget for location selection screen
// class LocationSelectionScreen extends StatefulWidget {
//   final Function(LatLng) onLocationSelected; // Callback function to return selected location
//
//   const LocationSelectionScreen({Key? key, required this.onLocationSelected}) : super(key: key);
//
//   @override
//   _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
// }
//
// class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
//   LatLng? _selectedLocation; // Store selected location
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Location'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Map goes here',
//               style: TextStyle(fontSize: 20),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Simulating location selection
//                 final selectedLocation = LatLng(37.42796133580664, -122.085749655962);
//                 setState(() {
//                   _selectedLocation = selectedLocation;
//                 });
//               },
//               child: Text('Select'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: _selectedLocation != null
//           ? FloatingActionButton(
//         onPressed: () {
//           // Pass selected location back to the previous screen
//           widget.onLocationSelected(_selectedLocation!);
//         },
//         child: Icon(Icons.check),
//       )
//           : null,
//     );
//   }
// }
