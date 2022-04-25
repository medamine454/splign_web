import 'dart:html';

import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  List<String> data_x;
  List<double> data_y;
  GraphScreen({Key? key, required this.data_x, required this.data_y})
      : super(key: key);
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: Text(
            "Tasks Management",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: [
            Feature(
              title: "Flutter",
              color: Colors.blue,
              data: widget.data_y,
            )
          ],
          size: Size(width * 0.8, 450),
          labelX: widget.data_x,
          labelY: ['Bad', 'Good'],
          showDescription: true,
          graphColor: Colors.black87,
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
