import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Text(
        "Options Screen \n Ima kiss a tree at 100mph",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 50,
          fontFamily: 'RedRose',
        ),
      ),
    );
  }
    
}