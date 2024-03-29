import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin{

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {//delay for 2 screens and then move to the main page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
        )
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(//container for the background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/SplashPage.png"),
            fit : BoxFit.cover,
            ),
        ),
      ),
    );
  }
}