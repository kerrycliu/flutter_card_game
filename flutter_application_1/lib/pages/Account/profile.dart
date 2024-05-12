import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? _user;

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
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 0, 153, 1),
              image: DecorationImage(
                image: AssetImage("images/login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          FutureBuilder(
            future: _getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _user = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // user icon
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
                    Text(
                      _user!.displayName?? "Username Temp Text",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Location Temp Text",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Friends Temp Text",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 450,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: const SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Friend1 Temp Text",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //...
                          ],
                        ),
                      ),
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
                          });
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Future<User?> _getUser() async {
    return _auth.currentUser;
  }
}