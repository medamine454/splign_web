import 'package:flutter/material.dart';
import 'package:splign_web/profile/components/Logout.dart';
import 'package:splign_web/profile/components/Settings.dart';
import 'package:splign_web/profile/components/profile_menu.dart';
import 'package:splign_web/profile/components/profile_pic.dart';
import 'package:splign_web/profile/edit/build_stream_foredit.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    required this.age,
    required this.emailadress,
    required this.weight,
    required this.height,
    required this.fullName,
  }) : super(key: key);
  String age;
  String weight;
  String height;
  String emailadress;
  String fullName;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          Center(
            child: Text(
              widget.fullName,
              style: TextStyle(
                fontFamily: 'Arial',
                color: Color.fromRGBO(26, 31, 56, 1),
                backgroundColor: Color(0xFFF5F6F9),
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePgg()),
              )
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogOut()),
              );
            },
          ),
        ],
      ),
    );
  }
}
