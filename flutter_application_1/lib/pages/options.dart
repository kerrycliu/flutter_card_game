import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  bool _hasPermission = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkPermission(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            _hasPermission = snapshot.data!;
            if (_hasPermission) {
              return FutureBuilder<Position>(
                future: getUserLocation(),
                builder: (context, positionSnapshot) {
                  if (positionSnapshot.hasError) {
                    return Text('Error: ${positionSnapshot.error}');
                  } else if (positionSnapshot.hasData) {
                    return Column(
                      children: [
                        const Text(
                          "Options Screen \nTemp Text",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Precise Location: ${positionSnapshot.data!.latitude}, ${positionSnapshot.data!.longitude}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        FutureBuilder<List<Placemark>>(
                          future: _getAddressFromLatLng(positionSnapshot.data!),
                          builder: (context, addressSnapshot) {
                            if (addressSnapshot.hasError) {
                              return Text('Error: ${addressSnapshot.error}');
                            } else if (addressSnapshot.hasData) {
                              final placemark = addressSnapshot.data!.first;
                              return Text(
                                'Address: ${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            } else {
              return Center(
                child: ElevatedButton(
                  child: Text('Grant Permission'),
                  onPressed: () async {
                    await Geolocator.requestPermission();
                    setState(() {});
                  },
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> _checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  Future<Position> getUserLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<List<Placemark>> _getAddressFromLatLng(Position position) async {
    final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks;
  }
}