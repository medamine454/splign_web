import 'package:flutter/material.dart';

class First_web extends StatefulWidget {
  const First_web({Key? key}) : super(key: key);

  @override
  State<First_web> createState() => _First_webState();
}

class _First_webState extends State<First_web> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(100),
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), //border corner radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: Text(
        "Box Shadow on Container",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
