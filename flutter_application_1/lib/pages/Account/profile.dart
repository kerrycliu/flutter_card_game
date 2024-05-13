// profile.dart
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  String? _username;
  List<String> _friends = [];

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
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Stack(
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
          Column(
            children: [
              Padding(
                //user icon
                padding: const EdgeInsets.all(65.0),
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
              StreamBuilder<String?>(
                stream: _getUsernameStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _username = snapshot.data;
                    return Text(
                      _username ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Friends",style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _friends.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(2),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 20),
                child: Column(
                  children: [
                    reuseableTextField(
                      "Enter Friend's Username",
                      Icons.account_box_outlined,
                      false,
                      TextEditingController(),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final friendUsername = TextEditingController().text;
                        final friendDoc = await db
                            .collection("users")
                            .where("username", isEqualTo: friendUsername)
                            .get();
                        if (friendDoc.docs.isNotEmpty) {
                          final friendUid = friendDoc.docs.first.id;
                          final currentUser = _auth.currentUser;
                          final friend = <String, String>{
                            "username": friendUsername,
                          };
                          final current = <String, String>{
                            "username": _username as String,
                          };
                          await db
                              .collection("friends")
                              .doc(currentUser!.uid)
                              .set(friend);
                          await db
                              .collection("friends")
                              .doc(friendUid)
                              .set(current);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Friend added successfully")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("User not found")));
                        }
                      },
                      child: const Text("Add Friend"),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text("Logout"),
                onPressed: () {
                  _auth.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const loginScreen()));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _fetchFriends() async {
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

  Stream<String?> _getUsernameStream() async* {
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
