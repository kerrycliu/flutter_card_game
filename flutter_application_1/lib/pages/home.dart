import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( //stack, layer elements on top of the other
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

              Column(//single player button
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[

                      Container(//card background
                        height: 189.75,//height of the card
                        width : 138.75,//width of the card
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width : 3.6),
                          image: const DecorationImage(
                            image: AssetImage("images/Cards/Spades/Rank=A, Suit=Spades.png"),
                            fit : BoxFit.cover,
                            ),
                        ),

                        child: ColorFiltered(//adjust the color of the image
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),//darken the image
                          child: const Image(
                            image: AssetImage("images/Cards/Spades/Rank=A, Suit=Spades.png"),
                            fit : BoxFit.cover,
                          ),
                        ),

                      ),

                      const Positioned(//single text
                        top : 7,
                        right : 10,
                        child : Text(
                          'Single',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                      const Positioned(//Player text
                        bottom : 7,
                        left : 10,
                        child : Text(
                          'Player',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                    ]
                  ),
                ],
              ),

              Column(//multiplayer button
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(//card background
                        height: 189.75,//height of the card
                        width : 138.75,//width of the card
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width : 3.6),
                          image: const DecorationImage(
                            image: AssetImage("images/Cards/Clubs/Rank=A, Suit=Clubs.png"),
                            fit : BoxFit.cover,
                            ),
                        ),

                        child: ColorFiltered(//adjust the color of the image
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),//darken the image
                          child: const Image(
                            image: AssetImage("images/Cards/Clubs/Rank=A, Suit=Clubs.png"),
                            fit : BoxFit.cover,
                          ),
                        ),

                      ),

                      const Positioned(//Multi text
                        top : 7,
                        right : 10,
                        child : Text(
                          'Multi',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                      const Positioned(//Player text
                        bottom : 7,
                        left : 10,
                        child : Text(
                          'Player',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                    ]
                  ),
                ],
              ),

              Column(//options button
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(//card background
                        height: 189.75,//height of the card
                        width : 138.75,//width of the card
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width : 3.6),
                          image: const DecorationImage(
                            image: AssetImage("images/Cards/Hearts/Rank=A, Suit=Heart.png"),
                            fit : BoxFit.cover,
                            ),
                        ),

                        child: ColorFiltered(//adjust the color of the image
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),//darken the image
                          child: const Image(
                            image: AssetImage("images/Cards/Hearts/Rank=A, Suit=Heart.png"),
                            fit : BoxFit.cover,
                          ),
                        ),

                      ),

                      const Positioned(//Options text
                        top : 7,
                        right : 10,
                        child : Text(
                          'Options',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                      const Positioned(//single text
                        bottom : 7,
                        left : 10,
                        child : Text(
                          'Options',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                    ]
                  ),
                ],
              ),

              Column(//profile button
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(//single player button
                    children: <Widget>[
                      Container(//card background
                        height: 189.75,//height of the card
                        width : 138.75,//width of the card
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width : 3.6),
                          image: const DecorationImage(
                            image: AssetImage("images/Cards/Diamonds/Rank=A, Suit=Diamond.png"),
                            fit : BoxFit.cover,
                            ),
                        ),

                        child: ColorFiltered(//adjust the color of the image
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),//darken the image
                          child: const Image(
                            image: AssetImage("images/Cards/Diamonds/Rank=A, Suit=Diamond.png"),
                            fit : BoxFit.cover,
                          ),
                        ),

                      ),

                      const Positioned(//Profile text
                        top : 7,
                        right : 10,
                        child : Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                      const Positioned(//Profile text
                        bottom : 7,
                        left : 10,
                        child : Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.75,
                            fontFamily: 'RedRose',
                          ),
                        ),
                      ),

                    ]
                  ),
                ],
              ),

            ]
          ),
        ],
      ),
    );
  }
}