import 'package:flutter/material.dart';

class Host extends StatelessWidget {
  const Host({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Text(
        "Host Screen \nTemp Text",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 50,
          fontFamily: 'RedRose',
        ),
      ),
    );
  }
}