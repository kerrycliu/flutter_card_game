import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body : Text(
        "Profile Screen \n Someone end me",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 50,
          fontFamily: 'RedRose',
        ),
      ),
    );
  }
}