// ignore_for_file: non_constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';
import 'package:flutter_application_1/pages/reuseable.dart';
import 'single_player.dart';
import 'Multi/multiplayer.dart';
import 'options.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 0, 10),
                  child: Container(
                    height: 225,
                    width: 350,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/MainLogo.png"),
                        fit: BoxFit.fitWidth,
                      )
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SinglePlayer())),
                        );
                      },
                      child: CardButton("images/Cards/Spades/Rank=A, Suit=Spades.png",
                          'Single', 'Player'), //Single Player Card
                    ),
                              
                    GestureDetector(
                      onTap: () async {
                        final List<ConnectivityResult> connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult.contains(ConnectivityResult.mobile) ||
                            connectivityResult.contains(ConnectivityResult.wifi)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const MultiPlayer())),
                          );
                        } else {
                          _showDialog(context);
                        }
                      },
                      child: CardButton("images/Cards/Clubs/Rank=A, Suit=Clubs.png",
                          'Multi', 'Player'), //Multi Player Card
                    ),
                  ],
                ),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: ((context) => Options())),
                        );
                      },
                      child: CardButton("images/Cards/Heart/Rank=A, Suit=Heart.png",
                          'Options', 'Options'), //Options Card
                    ),
                              
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const loginScreen())),
                        );
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

void _showDialog(BuildContext context) {
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
