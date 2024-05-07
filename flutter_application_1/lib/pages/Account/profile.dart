import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar : true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 0, 153, 1),
              image: DecorationImage(
              image: AssetImage("images/login_bg.png"),
              fit: BoxFit.fill,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 189.75, //height of the card
                width: 138.75, //width of the card
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "images/Cards/Joker.png"
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          
              Center(
                child: ElevatedButton(
                  child: const Text("Logout"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed Out");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const loginScreen()));
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
