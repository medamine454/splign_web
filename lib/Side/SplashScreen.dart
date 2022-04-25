import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, '/main/home');
    });
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Loading ..',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
