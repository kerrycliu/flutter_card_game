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

Container LoginSigninButton(
      BuildContext context, bool isLogin, Function onTap) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
        child: Text(
          isLogin ? 'Login' : 'Sign Up',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

TextField reuseableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(1)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 15,
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
