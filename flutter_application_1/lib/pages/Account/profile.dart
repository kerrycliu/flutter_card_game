// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Account/login_screen.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/reuseable.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance; //init auth
  var db = FirebaseFirestore.instance;//init database
  String? _username; //username string
  List<String> _friends = []; //list of friends to display

  final TextEditingController _friendTextController = TextEditingController();//friendusername var

  @override
  Widget build(BuildContext context) {
    return Scaffold(//main body widget
      resizeToAvoidBottomInset: false,//so the screen dont change when the keyboard is pulled up
      extendBodyBehindAppBar: true,//extend the background
      appBar: AppBar(
        backgroundColor: Colors.transparent,//appbar background to transparent
        elevation: 0,//make it rest at the bottom

        iconTheme: const IconThemeData(//icon edits
          color: Colors.white,
        ),

        title: const Text(
          "Profile",
          style: TextStyle(//font edits
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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

      body: Stack(//main body
        children: [

          Container(
            //background image
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 0, 153, 1),
              image: DecorationImage(
                image: AssetImage("images/login_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Column(//set widgets into a column
            children: [
              Column(//set widgets into a column
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,//space object evenly
                children: [
                  Padding(//spacing
                    //user icon
                    padding: const EdgeInsets.fromLTRB(100, 65, 100, 20),
                    child: Container(
                      height: 189.75, // height of the card
                      width: 138.75, // width of the card
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/Cards/Joker.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Row(//set widgets in a row
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,//space evenly
                    children: [
                      //get username
                      StreamBuilder<String?>(
                        stream: _getUsernameStream(),//grabs username from database
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {//if username exists
                            _username = snapshot.data;
                            return Text(
                              _username ?? '',//display username
                              style: const TextStyle(//font edits
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } 
                          
                          else {//if username doesnt exist
                            return const CircularProgressIndicator();//show continous loader
                          }
                        },
                      ),

                      ElevatedButton(//log out button
                        child: const Text("Logout"),
                        onPressed: () {//when pressed
                          _auth.signOut()//sign user out
                          .then((value) {//if signout successfull
                            print("Signed Out");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const loginScreen()//move the user to the home page
                                )
                            );
                          });
                        },
                      ),
                    ],
                  ),

                  Column(//sets widgets in a column
                    children: [
                      Padding(//spacing
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        child: reuseableTextField(//friend username textfield
                          "Enter Friend's Username",
                          Icons.account_box_outlined,
                          false,
                          _friendTextController,
                        ),
                      ),

                      ElevatedButton(//add friend button
                        onPressed: () async {//when pressed
                          final friendUsername = _friendTextController.text;//friendusername var

                          final friendDoc = await db//make a doc reference
                          .collection("users")//table users
                          .where("username", isEqualTo: friendUsername)//find matching username
                          .get();//get page

                          if (friendDoc.docs.isNotEmpty) {//if doc exists
                            final friendUid = friendDoc.docs.first.id;//get the uid of the friend
                            final token = friendDoc.docs.first.data()['fcm_token'];//get the fcmtoken for the user
                            //token is used for the push notification
                            final currentUser = _auth.currentUser;//grab current user uid

                            final friend = <String, String>{//make temp friend class
                              "username": friendUsername,
                            };
                            final current = <String, String>{//make temp friend class
                              "username": _username as String,
                            };
                            await db//add to database
                              .collection("users")//user table
                              .doc(currentUser!.uid)//uid page
                              .collection("friends")//friend table
                              .add(friend);//add class

                            await db//add to database
                              .collection("users")//user table
                              .doc(friendUid)//friend uid page
                              .collection("friends")//friend table
                              .add(current);//add class

                            // Send a push notification to the friend
                            await http.post(
                              Uri.parse('https://fcm.googleapis.com/fcm/send'),
                              headers: <String, String>{
                                'Content-Type': 'application/json',
                                'Authorization': 'key=AAAAvfZmxIg:APA91bFYjcEFwiTWHRlxakxlHghVGhnPDGLJ7E8Cht3MhGrhYJWKsZ0dZbJdWUu-cdWziE7LromoEm-0ZvrZzwWp3LieC9_tSlMwhCXh7-xhxxg7voQhyiET1x3b78TVs-GXj-uSZvt-', // Replace with your server key from the Firebase console
                              },
                              body: jsonEncode(<String, dynamic>{
                                'notification': <String, dynamic>{
                                  'body': 'Someone has added you as a friend!',
                                  'title': 'New Friend Added',
                                },
                                'priority': 'high',
                                'data': <String, dynamic>{
                                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                                  'id': '1',
                                  'status': 'done',
                                },
                                'to': token,
                              }),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(//if adding friend is successfull
                              const SnackBar(
                                  content: Text("Friend added successfully")//display this message at the button
                              )
                            );
                          } 
                          else {//if anything above fails!
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("User not found")//display this message at the bottom
                                )
                            );
                          }
                        },
                        child: const Text("Add Friend"),//button text
                      ),

                      //list of friends
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _friends.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                              child: ListTile(
                                title: Text(
                                  _friends[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _fetchFriends() async {//function to grab friends from the database
    final user = _auth.currentUser;
    if (user != null) {
      final friendDocs = await db
          .collection("users")
          .doc(user.uid)
          .collection("friends")
          .get();
      _friends = friendDocs.docs
          .map((doc) => doc.data()['username'] as String)
          .toList();
      setState(() {});
    }
  }

  Stream<String?> _getUsernameStream() async* {//function to grba the current user's username from the database
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        yield doc.data()?['username'];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }
}
