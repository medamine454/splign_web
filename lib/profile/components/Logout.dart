import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splign_web/Signup_login/welcomePage.dart';

import '../../app/constans/enum.dart';
import '../../app/shared_components/coustom_bottom_nav_bar.dart';
import '../../Backend/Firebase/authentication.dart';

class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logout"),
        backgroundColor: Color(0xff67bd42),
      ),
      body: Container(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 70,
              ),
              Text("Are You Sure You Want to Logout ?"),
              SizedBox(
                height: 50,
              ),
              Row(children: [
                RaisedButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    AuthenticationHelper().signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  splashColor: Colors.grey,
                ),
                SizedBox(
                  width: 70,
                ),
                RaisedButton(
                  child: Text(
                    "No",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: null,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Color(0xffeeeeed),
                )
              ]),
            ]),
          ),
          margin: EdgeInsets.symmetric(vertical: 140.0, horizontal: 80.0),
          decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
