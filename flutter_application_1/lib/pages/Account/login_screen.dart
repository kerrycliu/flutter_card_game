// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/profile.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/reuseable.dart';

import 'signup_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  final TextEditingController _passwordTextController = TextEditingController(); //password variable
  final TextEditingController _emailTextController = TextEditingController(); //email variable
  @override
  Widget build(BuildContext context) {
    return Stack(//for layering widgets
      children: [
        Scaffold(//main body widget
          extendBodyBehindAppBar: true,//extends the background to the appbar
          appBar: AppBar(
            backgroundColor: Colors.transparent,//appbar background to transparent
            elevation: 0,//make it rest at the bottom

            iconTheme: const IconThemeData(//icon edits
              color: Colors.white,
            ),

            title: const Text(
              "Login",
              style: TextStyle(//font edits
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),

            leading: BackButton(//confirm is the user presses the back button that are moved to the homepage
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage())
                );
              },
            ),

          ),

          body: Container(//main body

            decoration: const BoxDecoration(//background image
              color: Color.fromRGBO(77, 0, 153, 1),//base background color
              image: DecorationImage(
                image: AssetImage("images/login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),

            child: SingleChildScrollView(//make widgets into a scrollable item
              child: Padding(//spacing
                padding: EdgeInsets.fromLTRB(
                  50, 250, 50, MediaQuery.of(context).size.height
                ),

                child: Column(//set widgets into a column
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,//space them out evenly

                  children: [
                    const Padding(//spacing
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(height: 5),
                    ),

                    reuseableTextField(//email input
                      "Enter Email", 
                      Icons.email_outlined,
                      false,
                      _emailTextController
                    ),

                    const Padding(//spacing
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(height: 5),
                    ),

                    reuseableTextField(//password input
                      "Enter Password", 
                      Icons.lock_outline,
                      true, 
                      _passwordTextController
                    ),


                    const Padding(//spacing
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 10,
                      ),
                    ),

                    LoginSigninButton(context, true, () {//login button
                      FirebaseAuth.instance.signInWithEmailAndPassword(//auth function to check with the saved accounts
                        email: _emailTextController.text,//email var
                        password: _passwordTextController.text//password var
                      )
                      .then((value) {//if successfull
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Profile()) //move user to the profile screen
                        );
                      })

                      .onError((error, stackTrace) {//else failed
                        print("Error ${error.toString()}");//print to console
                      });

                    }),

                    signUpOption(),//sign up text
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,//align to the center
      children: [
        const Text(//text
          "Dont have account?",
          style: TextStyle(color: Colors.white),
        ),

        GestureDetector(//if the user clicks on the text
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const signUpPage())//move user to the signup page
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
