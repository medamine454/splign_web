import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splign_web/Side/pages/User_profile.dart';
import '../components/body.dart';
import 'edit_profile.dart';

class ProfilePgg extends StatefulWidget {
  @override
  _ProfilePggState createState() => _ProfilePggState();
}

class _ProfilePggState extends State<ProfilePgg> {
  String userName = '';
  String description = '';
  String img = '';
  int number = 0;
  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    if (user != null) {
      List<String> patients_accepted = [];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        description = value.data()!['Description'];
        userName = value.data()!['Username'];
        img = value.data()!['ImgUrl'];
        patients_accepted = value.data()!['accepted_patients'].cast<String>();
        number = patients_accepted.length;
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else {
                return UserProfilePage(
                  bio: description,
                  fullName: userName,
                  posts: number,
                  status: img,
                );
              }
            }));
  }
}
