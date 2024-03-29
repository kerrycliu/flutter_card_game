import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'Host.dart';
import 'Join.dart';

class MultiPlayer extends StatelessWidget {
  const MultiPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Multiplayer_Stack(context)
    );
  }

  Stack Multiplayer_Stack(BuildContext context) {
    return Stack(
      children: [
        Container(//container for the background image
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit : BoxFit.cover,
              ),
          ),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) => const HomePage())),
            );
          },
          child: Back_button(),
        ),

        Row(//buttons
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : [

            GestureDetector(
              onTap: () {
                Navigator.push( 
                  context,
                  MaterialPageRoute(builder: ((context) => const Host())),
                );
              },
              child : CardButton("images/Cards/Clubs/Rank=K, Suit=Clubs.png", 'Host', 'Host'), //Host Card
            ),

            GestureDetector(
              onTap: () {
                Navigator.push( 
                  context,
                  MaterialPageRoute(builder: ((context) => const Join())),
                );
              },
              child : CardButton("images/Cards/Clubs/Rank=Q, Suit=Clubs.png", 'Join', 'Join'), //Join Card
            ),

          ]
        ),
      ],
    );
  }

  Positioned Back_button() {
    return Positioned(
      top: 10,
      left: 10,
        child: Container(//container for the background image
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Go_Back.png"),
              fit : BoxFit.cover,
            ),
          ),
        ),
      );
  }

  Column CardButton(String cardImage, String topText, String bottomText) {
    return Column(//single player button
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[

                  Container(//card background
                    height: 253.23,//height of the card
                    width : 185.52,//width of the card
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