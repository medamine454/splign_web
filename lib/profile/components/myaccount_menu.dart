import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Color.fromRGBO(26, 31, 56, 1),
            padding: EdgeInsets.all(20),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Color(0xFFF5F6F9),
          ),
          onPressed: () {},
          child: Row(
              children: [
                SizedBox(width: 20),
                Expanded(child : Text(text)),
                Icon(Icons.edit),
              ]
          ),
        ),
      );

  }
}