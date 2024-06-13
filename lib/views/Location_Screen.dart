import 'package:flutter/material.dart';
import 'package:fule_and_vm_app/home_screen.dart';
import 'package:fule_and_vm_app/views/Admin/admin_profile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late WebViewController _webViewController;

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getLocationName(Position position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      return '${placemarks.first.locality}, ${placemarks.first.country}';
    }
    return 'Unknown location';
  }

  Future<bool> _checkUserAdmin(String userUid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Admins')
          .doc(userUid)
          .get();
      return documentSnapshot.exists && documentSnapshot.data() != null;
    } catch (error) {
      print('Error checking user admin status: $error');
      return false;
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch current location.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getLocationAndNavigate() async {
    Position? currentPosition = await _determinePosition();
    if (currentPosition != null) {
      String locationName = await _getLocationName(currentPosition);
      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;

      bool isAdmin = await _checkUserAdmin(currentUserUid!);

      if (isAdmin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminProfileDetails(selectedLocationName: locationName),
          ),
        );
      } else {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Get.off(Home_Screen(selectedLocationName: locationName));
        });
      }
    } else {
      _showErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Location'),
        
        leading: IconButton(onPressed: (){

          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: WebView(
        initialUrl: 'https://www.google.com/maps',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocationAndNavigate,
        child: Icon(Icons.check),
      ),
    );
  }
}
