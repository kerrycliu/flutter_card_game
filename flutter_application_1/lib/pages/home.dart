// ignore_for_file: non_constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'single_player.dart';
import 'multiplayer.dart';
import 'options.dart';
import 'profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
            //home page buttons
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // for 3 cards
              // height : 253.23
              // width : 185.52

              // for 4 cards
              // height :
              // width :

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
                  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
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
                    MaterialPageRoute(builder: ((context) => const Profile())),
                  );
                },
                child: CardButton(
                    "images/Cards/Diamond/Rank=A, Suit=Diamond.png",
                    'Profile',
                    'Profile'), //Profile Card
              ),
            ]),
      ],
    );
  }

Column CardButton(String cardImage, String topText, String bottomText) {
    return Column(
      //single player button
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: <Widget>[
          Container(
            //card background
            height: 189.75, //height of the card
            width: 138.75, //width of the card
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3.6),
              image: DecorationImage(
                image: AssetImage(cardImage),
                fit: BoxFit.cover,
              ),
            ),

            child: ColorFiltered(
              //adjust the color of the image
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                  BlendMode.darken), //darken the image
              child: Image(
                image: AssetImage(cardImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            //Top text
            top: 7,
            right: 10,
            child: Text(
              topText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.75,
                fontFamily: 'RedRose',
              ),
            ),
          ),
          Positioned(
            //Buttom text
            bottom: 7,
            left: 10,
            child: Text(
              bottomText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.75,
                fontFamily: 'RedRose',
              ),
            ),
          ),
        ]),
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
        content: const Text("Please connect to the internet to play multiplayer."),
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
