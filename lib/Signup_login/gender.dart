import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splign_web/Signup_login/Widget/bezierContainer.dart';
import 'package:splign_web/Signup_login/age.dart';
import 'package:splign_web/Signup_login/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splign_web/Signup_login/welcomePage.dart';
import '../Backend/Firebase/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GenderPage extends StatefulWidget {
  GenderPage({Key? key, this.title, required this.user}) : super(key: key);

  final String? title;
  final User user;

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  bool isChecked = false;
  String role = "male";
  TextEditingController username_ctrl = TextEditingController();
  TextEditingController email_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();
  bool isLoading = false;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController text,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        DocumentReference ref =
            FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
        await ref
            .update({'Gender': role})
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AgePage(
                      user: widget.user,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromARGB(255, 58, 53, 48).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Color(0xff67bd42)),
        child: Text('Next',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey[800]!;
      }
      return Color(0xff67bd42);
    }

    bool value = false;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                change_role("male");
                print(role);
              },
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                      color: Color(0xffdfdeff),
                      image: DecorationImage(
                        image: AssetImage('assets/Male.png'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Male",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffededed),
                    ),
                    child: (role == "male")
                        ? Icon(
                            Icons.check_circle,
                            color: Color(0xff67bd42),
                            size: 30,
                          )
                        : Container(),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                change_role("female");
              },
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width * 0.43,
                    decoration: BoxDecoration(
                      color: Color(0xffdfdeff),
                      image: DecorationImage(
                        image: AssetImage('assets/female.png'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Female",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffededed),
                    ),
                    child: (role == "female")
                        ? Icon(
                            Icons.check_circle,
                            color: Color(0xff67bd42),
                            size: 30,
                          )
                        : Container(),
                  )
                ],
              ),
            ),
          ],
        ),
        //_entryField("Please enter your Age", username_ctrl),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (isLoading == false) {
      return Scaffold(
        body: Center(
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .3),
                        Text('Please select your Gender',
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: Colors.black)),
                        SizedBox(
                          height: 20,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 30,
                        ),
                        _submitButton(),
                        SizedBox(height: height * .14),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xff67bd42),
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 140,
          ),
        ),
      );
    }
  }

  void change_role(String type) {
    role = type;
    setState(() {});
  }
}
