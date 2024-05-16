
// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';
import 'package:flutter_application_1/pages/Account/profile.dart';
import 'package:flutter_application_1/pages/reuseable.dart';
import 'single_player.dart';
import 'Multi/multiplayer.dart';
import 'options.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(184, 170, 255, 100),
      body: Main_Stack(context),
    );
  }

  Stack Main_Stack(BuildContext context) {
    return Stack(
      //stack, layer elements on top of the other
      children: [
        Container(
          //container for the background image
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Vertical_BG.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Center(
          child: Column(
              //home page buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,//space object evenly
              crossAxisAlignment: CrossAxisAlignment.center,//center the objects
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 0, 10),
                  child: Container(//top logo for the home page
                    height: 225,
                    width: 350,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("images/MainLogo.png"),
                      fit: BoxFit.fitWidth,
                    )),
                  ),
                ),

                Row(//first row of buttons
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,//space them evenly
                  children: [
                    //singleplayer
                    GestureDetector(//when the button is pressed on
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const SinglePlayer())//move the user to this page
                          ), //
                        );
                      },
                      child: CardButton(
                          "images/Cards/Spades/Rank=A, Suit=Spades.png",
                          'Single',
                          'Player'), //Single Player Card
                    ),

                    //multiplayer
                    GestureDetector(//when the button is pressed on
                      onTap: () async {
                        final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity()); //init connection
                        if (
                          connectivityResult.contains(ConnectivityResult.mobile) || //if the user is on mobile
                          connectivityResult.contains(ConnectivityResult.wifi) //if the user is on wifi
                          ) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const MultiPlayer())//move the user to this page
                            ),
                          );
                        } else {
                          _showDialog(context);
                        }
                      },
                      child: CardButton(
                          "images/Cards/Clubs/Rank=A, Suit=Clubs.png",
                          'Multi',
                          'Player'), //Multi Player Card
                    ),
                  ],
                ),

                Row(//second row of buttons
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,//space them evenly
                  children: [

                    //option button 
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const Options())//move the user to this page
                          ),
                        );
                      },
                      child: CardButton(
                          "images/Cards/Heart/Rank=A, Suit=Heart.png",
                          'Options',
                          'Options'), //Options Card
                    ),

                    //profile button
                    GestureDetector(
                      onTap: () {
                        final currentUser = _auth.currentUser; //check if the user is logged in before
                        if (currentUser != null) { //if the user has logged in
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const Profile())//move user to the profile page
                            ),
                          );
                        } else {//user hasnt logged in before or has logged out
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const loginScreen())//move user to the login page
                            ),
                          );
                        }
                      },
                      child: CardButton(
                          "images/Cards/Diamond/Rank=A, Suit=Diamond.png",
                          'Profile',
                          'Profile'), //Profile Card
                    ),
                  ],
                ),
              ]),
        ),
      ],
    );
  }
}

void _showDialog(BuildContext context) {//function to prompt the user to connect to the internet
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("No Internet Connection"),
        content:
            const Text("Please connect to the internet to play multiplayer."),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
