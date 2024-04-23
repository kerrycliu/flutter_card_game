import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: getUserLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: [
                const Text(
                  "Options Screen \nTemp Text",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontFamily: 'RedRose',
                  ),
                ),
                Text(
                  'Location: ${snapshot.data!.latitude}, ${snapshot.data!.longitude}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Future<Position> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    // Location services are not enabled, show an error message
    return Future.error('Location services are disabled.');
  }


  // Check if the app has permission to access the user's location
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // The user denied permission, show an error message
      return Future.error('Location permission denied.');
    }

  }

  // Get the user's current location
  return await Geolocator.getCurrentPosition();
}