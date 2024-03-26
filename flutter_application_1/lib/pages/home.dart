import 'package:flutter/material.dart';
import 'single_player.dart';
import 'multiplayer.dart';
import 'options.dart';
import 'profile.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Main_Stack(context),
    );
  }

  Stack Main_Stack(BuildContext context) {
    return Stack( //stack, layer elements on top of the other
      children: [
        Container(//container for the background image
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit : BoxFit.cover,
              ),
          ),
        ),
        Row(//home page buttons
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : [
            
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
                  MaterialPageRoute(builder: ((context) => const SinglePlayer())),
                );
              },
              child : CardButton("images/Cards/Spades/Rank=A, Suit=Spades.png", 'Single', 'Player'), //Single Player Card
            ),

            GestureDetector(
              onTap: () {
                Navigator.push( 
                  context,
                  MaterialPageRoute(builder: ((context) => const MultiPlayer())),
                );
              },
              child : CardButton("images/Cards/Clubs/Rank=A, Suit=Clubs.png", 'Multi', 'Player'), //Multi Player Card
            ),

            GestureDetector(
              onTap: () {
                Navigator.push( 
                  context,
                  MaterialPageRoute(builder: ((context) => const Options())),
                );
              },
              child : CardButton("images/Cards/Hearts/Rank=A, Suit=Heart.png", 'Options', 'Options'), //Options Card
            ),

            GestureDetector(
              onTap: () {
                Navigator.push( 
                  context,
                  MaterialPageRoute(builder: ((context) => const Profile())),
                );
              },
              child : CardButton("images/Cards/Diamonds/Rank=A, Suit=Diamond.png", 'Profile', 'Profile'), //Profile Card
            ),

          ]
        ),
      ],
    );
  }

  Column CardButton(String cardImage, String topText, String bottomText) {
    return Column(//single player button
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[

                  Container(//card background
                    height: 189.75,//height of the card
                    width : 138.75,//width of the card
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width : 3.6),
                      image: DecorationImage(
                        image: AssetImage(cardImage),
                        fit : BoxFit.cover,
                        ),
                    ),

                    child: ColorFiltered(//adjust the color of the image
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),//darken the image
                      child: Image(
                        image: AssetImage(cardImage),
                        fit : BoxFit.cover,
                      ),
                    ),

                  ),

                  Positioned(//Top text
                    top : 7,
                    right : 10,
                    child : Text(
                      topText,
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 24.75,
                        fontFamily: 'RedRose',
                      ),
                    ),
                  ),

                  Positioned(//Buttom text
                    bottom : 7,
                    left : 10,
                    child : Text(
                      bottomText,
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 24.75,
                        fontFamily: 'RedRose',
                      ),
                    ),
                  ),

                ]
              ),
            ],
          );
  }
}