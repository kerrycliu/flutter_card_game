// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(77, 0, 153, 1),
          image: DecorationImage(
            image: AssetImage("images/login_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                50, 250, 50, MediaQuery.of(context).size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(height: 5),
                ),
                reuseableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(height: 5),
                ),
                reuseableTextField("Enter Username", Icons.lock_outline, false,
                    _userNameTextController),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                reuseableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                LoginSigninButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    final user = <String, String>{
                      "username" : _userNameTextController.text,
                      "email" : _emailTextController.text,
                    };

                    db.collection("users").doc(value.user!.uid).set(user);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  }).onError((error, stackTrace) {
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