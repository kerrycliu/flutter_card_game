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
  Position? _currentLocation; //location in coordinates
  bool _servicePermission = false; //assume permission hasnt been given
  LocationPermission? _permission; //location permission
  String _currentAddress = "null"; //string of the address of the user

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; //init database

  Future<Position> _getCurrentLocation() async { //function get current user location in coordinates
    try {
      _servicePermission = await Geolocator.isLocationServiceEnabled(); //check for permissions
      if (!_servicePermission) {//if not given
        print("Location service is disabled");//print to console
        return Future.error("Location service is disabled");//print to console
      }

      _permission = await Geolocator.checkPermission();//ask for permission
      if (_permission == LocationPermission.denied) {//default isnt given
        _permission = await Geolocator.requestPermission();//request for permission
      }

      return await Geolocator.getCurrentPosition();// get location in coordinates and return
    } catch (e) {//error catch
      print("Error getting current location: $e");
      return Future.error("Error getting current location: $e");
    }
  }

  Future<void> _getAddressFromCoordinates() async {//function to get address from coordinates
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);//convert lat and long into a placemarker

      Placemark place = placemarks[0]; //get first place marker
      //there should only be one

      setState(() {//update variables
        _currentAddress = "${place.street}, ${place.locality}"; //get street, get city
      });
    } catch (e) {//error catch
      print("Error getting address: $e");
    }
  }

  Future<void> _getCoordinatesFromAddress() async {//function to get coordinates from address
    try {
      List<Location> location = await locationFromAddress(_currentAddress);//convert string address into a location

      Location loc = location[0];//get first location
      //there should only be one

      setState(() {
        _currentLocation = Position(
          longitude: loc.longitude, //convert to long
          latitude: loc.latitude, //convert to lat
          timestamp: loc.timestamp, //convert to timestamp of collected date
          accuracy: 0, //idk
          altitude: 0, //idk
          altitudeAccuracy: 0, //idk 
          heading: 0, //idk
          headingAccuracy: 0, //idk 
          speed: 0, //idk
          speedAccuracy: 0 //idk
          );
      });
    } catch (e) {
      print("Error getting addres coordinates: $e");
    }
  }

  Future<void> _updateUserLocationInDatabase() async {//add user location to the database for future use
    try {
      final user = FirebaseAuth.instance.currentUser; //if user is logged in, get userid
      if(user != null){//check if the user is logged in
        await _firestore.collection("users").doc(user.uid).update({ //add information to the data, col(users) doc(uid)
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
      resizeToAvoidBottomInset: false,//so the screen dont change when the keyboard is pulled up
      extendBodyBehindAppBar: true,//extend the background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(//font edits
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: BackButton(//when pushing the back button, confirmed reroute to the homepage
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

          Padding(
            padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
            child: Column( // have all items in a column
              mainAxisAlignment: MainAxisAlignment.start, //start from the top
              crossAxisAlignment: CrossAxisAlignment.center, //center placment 
              children: [
                const Text( //basic texts
                  "Coordinates",
                  style: TextStyle(//font edits
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildLocationCoordinatesText(), //widget to show the collected location data in coordinates
                const SizedBox(height: 30),//spacing
                const Text(//basic texts
                  "Address",
                  style: TextStyle( //font edits
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildLocationAddressText(),//widget to show the collected location data as an address
                SizedBox(height: 40),
                _buildGetLocationButton(),// widget to get location information using location functions

                //since the prof asked for an option from the user to that they can input an address themselves to lower the amount of privacy invasion
                Padding(//spacing
                  padding: const EdgeInsets.fromLTRB(55, 20, 55, 5),
                  child: TextField(//text input box
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {//set input text to the variable
                      _currentAddress = value;
                    },
                    decoration: const InputDecoration(//temp text in the box
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
          
                ElevatedButton(//button to work with the input text box
                  onPressed: () async {
                    try {
                      await _getCoordinatesFromAddress();//call function
                      await _updateUserLocationInDatabase();//call function
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

  Widget _buildGetLocationButton() {//button to use with location functions
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

