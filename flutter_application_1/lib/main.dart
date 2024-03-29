import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:location/location.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();//initialized app preferred orientiation
  SystemChrome.setPreferredOrientations([//set app to only be in landscape mode
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}