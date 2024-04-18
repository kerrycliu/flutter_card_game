import 'package:flutter/material.dart';

class Join extends StatelessWidget {
  const Join({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Text(
        "Join Screen \nTemp Text",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 50,
          fontFamily: 'RedRose',
        ),
      ),
    );
  }
}