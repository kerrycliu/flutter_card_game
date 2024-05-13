// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  Position? _currentLocation;
  bool _servicePermission = false;
  LocationPermission? _permission;
  String _currentAddress = "null";

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Position> _getCurrentLocation() async {
    try {
      _servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!_servicePermission) {
        print("Location service is disabled");
        return Future.error("Location service is disabled");
      }

      _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print("Error getting current location: $e");
      return Future.error("Error getting current location: $e");
    }
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.street}, ${place.locality}";
      });
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  Future<void> _getCoordinatesFromAddress() async {
    try {
      List<Location> location = await locationFromAddress(_currentAddress);

      Location loc = location[0];

      setState(() {
        _currentLocation = Position(
          longitude: loc.longitude, 
          latitude: loc.latitude, 
          timestamp: loc.timestamp, 
          accuracy: 0, 
          altitude: 0, 
          altitudeAccuracy: 0, 
          heading: 0, 
          headingAccuracy: 0, 
          speed: 0, 
          speedAccuracy: 0);
      });
    } catch (e) {
      print("Error getting addres coordinates: $e");
    }
  }

  Future<void> _updateUserLocationInDatabase() async {
    try {
      // Assume you have a user ID stored in a variable called userId
      final user = FirebaseAuth.instance.currentUser;
      if(user != null){
        await _firestore.collection("users").doc(user.uid).update({
        "location": {
          "latitude": _currentLocation!.latitude,
          "longitude": _currentLocation!.longitude,
          "address": _currentAddress,
        },
      });
      }
    } catch (e) {
      print("Error updating user location in database: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            //background image
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 0, 153, 1),
              image: DecorationImage(
                image: AssetImage("images/login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Coordinates",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildLocationCoordinatesText(),
                SizedBox(height: 30),
                const Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildLocationAddressText(),
                SizedBox(height: 50),
                _buildGetLocationButton(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 5, 55, 5),
                  child: TextField(
                    onChanged: (value) {
                      _currentAddress = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter Address : Street",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 10,
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _getCoordinatesFromAddress();
                      await _updateUserLocationInDatabase();
                    }
                    catch(e) {
                      print("Error getting location: $e");
                    }
                  }, 
                  child: Text("Enter Location")),
          
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCoordinatesText() {
    return Text(
      "Latitude = ${_currentLocation?.latitude}; \nLongitude = ${_currentLocation?.longitude}",
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _buildLocationAddressText() {
    return Text(
      "${_currentAddress}",
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _buildGetLocationButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          _currentLocation = await _getCurrentLocation();
          await _getAddressFromCoordinates();
          print("${_currentLocation}");
          await _updateUserLocationInDatabase();
        } catch (e) {
          print("Error getting location: $e");
        }
      },
      child: Text("Get Location"),
    );
  }
}