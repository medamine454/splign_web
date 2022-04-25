import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splign_web/Signup_login/Description_doctor.dart';
import 'package:splign_web/Signup_login/Widget/bezierContainer.dart';
import 'package:splign_web/Signup_login/gender.dart';
import 'package:splign_web/Signup_login/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splign_web/Signup_login/welcomePage.dart';
import '../Backend/Firebase/authentication.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  String role = "patient";
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
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.35,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Color(0xfff3f3f4),
                  filled: false))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        AuthenticationHelper()
            .signUp(
          email: email_ctrl.text,
          password: password_ctrl.text,
          username: username_ctrl.text,
        )
            .then((result) async {
          if (result == null) {
            setState(() {
              isLoading = true;
            });
            final user = FirebaseAuth.instance.currentUser;
            DocumentReference ref =
                FirebaseFirestore.instance.collection('users').doc(user!.uid);
            await ref
                .set({
                  'id': user.uid,
                  'Username': username_ctrl.text,
                  'Email': email_ctrl.text,
                  'Password': password_ctrl.text,
                  'role': 'doctor',
                  'searchKey': username_ctrl.text[0].toUpperCase(),
                  'ImgUrl':
                      'https://firebasestorage.googleapis.com/v0/b/splign-posture.appspot.com/o/22-223941_transparent-avatar-png-male-avatar-icon-transparent-png.png?alt=media&token=908e32af-f7c9-4569-8b93-0e909e18db85'
                })
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
            setState(() {
              isLoading = false;
            });

            if (role == 'patient') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GenderPage(
                            user: user,
                          )));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DesciprionDoctor(
                            user: user,
                          )));
            }
          } else {
            final snackBar = SnackBar(content: Text(result));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
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
        child: Text('Register now',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff67bd42),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
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
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        _entryField("Username", username_ctrl),
        _entryField("Email id", email_ctrl),
        _entryField("Password", password_ctrl, isPassword: true),
        Container(
          width: width * 0.35,
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text(
                "I agree to",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctxt) => new AlertDialog(
                              title: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You. We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.\n\n'),
                                    TextSpan(
                                        text: 'Personal Data \n',
                                        style: new TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to: • Email address\n • First name and last name\n • Phone number\n • Address, State, Province, ZIP/Postal code, City\n • Usage Data\n\n'),
                                    TextSpan(
                                        text: "Children's Privacy \n",
                                        style: new TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            "Our Service does not address anyone under the age of 18. We do not knowingly collect personally identifiable information from anyone under the age of 18.\n\n"),
                                  ])),
                            ));
                  },
                  child: Text('terms and policies',
                      style: TextStyle(
                        color: Color(0xff67bd42),
                        fontSize: 15,
                      ))),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (isLoading == false) {
      return Scaffold(
        body: Container(
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
                      SizedBox(height: height * .05),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: width * 0.4,
                            ),
                            Image.asset(
                              'assets/logo_green.png',
                              height: 80,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            _emailPasswordWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            _submitButton(),
                            SizedBox(
                              height: 30,
                              width: width * 0.4,
                            ),
                          ],
                        ),
                      ),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ],
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
