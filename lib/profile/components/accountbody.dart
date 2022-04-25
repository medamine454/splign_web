import 'package:flutter/cupertino.dart';

import 'myaccount_menu.dart';

class AccountBody extends StatelessWidget {
  static const email = "me.mohsen@gmail.com";
  static const name = "Mohsen weld mohsna";
  static const phone = "90441530"; // not real number :)
  static const location = "Ariana,Tunisia";
  static const age = "38";
  static const gender = "Male";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          AccountMenu(
            text:  "Name :"+ name,
            press: () => {},
          ),
          SizedBox(height: 2),
          AccountMenu(
            text: "Age : "+age,
            press: () => {},
          ),
          SizedBox(height: 2),
          AccountMenu(
            text: "Gender : " + gender,
            press: () => {},
          ),
          SizedBox(height: 2),
          AccountMenu(
            text: "Phone number : "+phone,
            press: () => {},
          ),
          SizedBox(height: 2),
          AccountMenu(
            text: "Email : " + email,
            press: () => {},
          ),
          SizedBox(height: 2),
          AccountMenu(
            text: "Location : " + location,
            press: () => {},
          ),
        ],
      ),
    );
  }
}
