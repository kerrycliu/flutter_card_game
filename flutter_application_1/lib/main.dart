// ignore_for_file: camel_case_types
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/firebase_api.dart';
import 'package:flutter_application_1/pages/home.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';

import 'pages/Multi/multiplayer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAXAEWCWsUrSY3CN8YmEJzfRVDmNh-h9LE",
          appId: '1:815882749064:android:1d9519fb0988a37c8ecb3d',
          messagingSenderId: '815882749064',
          projectId: "kards-c7448",)
          );
  await FirebaseAPi().initNotification();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(myApp(navigatorKey: navigatorKey));
}

class myApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const myApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        MultiPlayer.route: (context) => const MultiPlayer(),
      },
      navigatorKey: navigatorKey,
    );
  }
}
