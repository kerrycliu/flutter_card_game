import 'package:flutter/material.dart';

class MultiPlayer extends StatelessWidget {
  const MultiPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Text(
        "Multiplayer Screen \n I hate my life",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 50,
          fontFamily: 'RedRose',
        ),
      ),
    );
  }
}