import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  String? _username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Container(//background image
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 0, 153, 1),
              image: DecorationImage(
                image: AssetImage("images/login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(65.0),
            child: Container(
              height: 189.75, // height of the card
              width: 138.75, // width of the card
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/Cards/Joker.png"
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //display username
          FutureBuilder<String?>(
            future: _getUsername(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _username = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the username here
                    Text(
                      _username ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Add other widgets here
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),

          Center(
            child: ElevatedButton(
              child: const Text("Logout"),
              onPressed: () {
                _auth.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const loginScreen()));
                }
              );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _getUsername() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['username'];
      }
    }
    return null;
  }
}