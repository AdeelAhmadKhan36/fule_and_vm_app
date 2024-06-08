
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Location'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _selectLocation(context);
          },
          child: Text('Select Current Location'),
        ),
      ),
    );
  }

  Future<void> _selectLocation(BuildContext context) async {
    Position? currentPosition = await _determinePosition();
    if (currentPosition != null) {
      // Use addPostFrameCallback to ensure navigation happens after build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, currentPosition);
      });
    } else {
      // Show error dialog if location fetch fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch current location.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
}

