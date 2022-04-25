import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile.dart';

class EditProfilePgg extends StatefulWidget {
  @override
  _EditProfilePggState createState() => _EditProfilePggState();
}

class _EditProfilePggState extends State<EditProfilePgg> {
  late String email;
  late String role;
  late String userName;
  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        email = value.data()!['Email'];
        userName = value.data()!['Username'];
        role = value.data()!['role'];
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
                return EditprOFILE(
                  emailadress: email,
                  fullName: userName,
                );
              }
            }));
  }
}
