// ignore_for_file: camel_case_types
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/api/firebase_api.dart';
import 'package:flutter_application_1/pages/Account/profile.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(//init firebase
      options: const FirebaseOptions(
          apiKey: "AIzaSyAXAEWCWsUrSY3CN8YmEJzfRVDmNh-h9LE",
          appId: '1:815882749064:android:1d9519fb0988a37c8ecb3d',
          messagingSenderId: '815882749064',
          projectId: "kards-c7448",)
          );
  await FirebaseAPi().initNotification(); // init notif

  runApp(const myApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
}

class myApp extends StatelessWidget {

  const myApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/profile_screen': (context) =>const Profile(),
      },
    );
  }
}
