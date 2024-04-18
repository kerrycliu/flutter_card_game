import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Column(
        children: [
          Text(
            "Options Screen \nTemp Text",
            style: TextStyle(
              color: Colors.black, 
              fontSize: 50,
              fontFamily: 'RedRose',
            ),
          ),
          Text(
            "Location : ",
            style: TextStyle(
              color: Colors.black, 
              fontSize: 50,
            ),
          ),
        ],
      ),
    );
  }
    
}