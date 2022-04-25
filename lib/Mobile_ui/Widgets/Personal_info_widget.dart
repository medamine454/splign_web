import 'package:flutter/material.dart';

class Person_widget_info extends StatefulWidget {
  const Person_widget_info({Key? key}) : super(key: key);

  @override
  _Person_widget_infoState createState() => _Person_widget_infoState();
}

class _Person_widget_infoState extends State<Person_widget_info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Enter your data',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            child: Container(
              decoration: myBoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                ),
              ),
            ),
            padding: EdgeInsets.all(40.0),
          )
        ]),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //         <--- border radius here
          ),
    );
  }
}
