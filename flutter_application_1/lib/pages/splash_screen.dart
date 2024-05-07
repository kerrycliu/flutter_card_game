import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      //delay for 2 screens and then move to the main page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(184, 170, 255, 100),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 150),
        child: Container(
          //container for the background image
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Splash_logo.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(75, 50, 75, 125),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
