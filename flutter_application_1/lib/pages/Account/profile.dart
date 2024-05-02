import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const loginScreen()));
          },
        ),
      )
    );
  }
}
