// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Column CardButton(String cardImage, String topText, String bottomText) {
    return Column(
      //single player button
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(children: <Widget>[
          Container(
            //card background
            height: 210, //height of the card
            width: 145, //width of the card
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
              ),
            ),
          ),
        ]),
      ],
    );
  }