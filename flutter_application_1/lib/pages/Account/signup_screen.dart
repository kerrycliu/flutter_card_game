// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/profile.dart';
import 'package:flutter_application_1/pages/reuseable.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  var db = FirebaseFirestore.instance;
  final TextEditingController _passwordTextController = TextEditingController();//password var
  final TextEditingController _emailTextController = TextEditingController();//email var
  final TextEditingController _userNameTextController = TextEditingController();//username var

  Future<String?> _getfcmToken() async {//function to get the device messageing token
    FirebaseMessaging messaging = FirebaseMessaging.instance;//init lib
    String? fcmToken = await messaging.getToken();//grab token
    return fcmToken;//return token
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(//main body widget
        backgroundColor: Colors.transparent,//appbar background to transparent
        elevation: 0,//make it rest at the bottom

        iconTheme: const IconThemeData(//icon edits
          color: Colors.white,
        ),


        title: const Text(
          "Sign Up",
          style: TextStyle(//font edits
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

      ),
      
      body: Container(//main body

        decoration: const BoxDecoration(//background image
          color: Color.fromRGBO(77, 0, 153, 1),//base background color
          image: DecorationImage(
            image: AssetImage("images/login_bg.png"),
            fit: BoxFit.fill,
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

                reuseableTextField(//username input
                  "Enter Username", 
                  Icons.person_outline, 
                  false,
                  _userNameTextController
                ),

                const Padding(//spacing
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 10,
                  ),
                ),

                reuseableTextField(
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

                LoginSigninButton(context, false, () {//signup button
                  FirebaseAuth.instance.createUserWithEmailAndPassword(//create user account with email and password
                    email: _emailTextController.text,//email var
                    password: _passwordTextController.text//password var
                  )
                  .then((value) async {//if successful

                    final user = <String, String>{//create temp user class for the database
                      "username" : _userNameTextController.text,//username var
                      "email" : _emailTextController.text,//email var
                      "password" : _passwordTextController.text,//password var
                    };

                    final user_token = <String, String>{};//create temp token class for the database

                    String? fcmToken = await _getfcmToken();//grab token

                    if(fcmToken != null) {//if able to grab token
                      user_token["fcm_token"] = fcmToken;//add to class
                      user["fcm_token"] = fcmToken;//add to class
                    }

                    db.collection("users").doc(value.user!.uid).set(user);//add to db
                    db.collection("users_token").doc(value.user!.uid).set(user_token);//add to db

                    Navigator.push(
                      context,
                        MaterialPageRoute(builder: (context) => const Profile())//move user to the profile page
                      );
                  })
                  .onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}