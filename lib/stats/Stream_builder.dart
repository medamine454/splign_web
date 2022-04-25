import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:splign_web/stats/stats_page.dart';

class StreamStats extends StatefulWidget {
  String ID_of_patient = '';

  StreamStats({Key? key, required this.ID_of_patient}) : super(key: key);

  @override
  _StreamStatsState createState() => _StreamStatsState();
}

class _StreamStatsState extends State<StreamStats> {
  List<FlSpot> list_points = [];
  double minX = 0;
  double maxX = 24;
  double good_percent = 0;

  _fetch() async {
    list_points = [];
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.ID_of_patient)
        .collection('Gadget')
        .doc('Q2IBBFqtB6y94Wfyj6zT')
        .collection('Measurement');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.ID_of_patient)
        .collection('Gadget')
        .doc('Q2IBBFqtB6y94Wfyj6zT')
        .collection('Measurement')
        .orderBy('Date_Time')
        .get();

    QuerySnapshot querySnapshot_2 = await FirebaseFirestore.instance
        .collection("users")
        .doc('ADbyzv77pPeOtxwf3ai7JMdEho82')
        .collection('Gadget')
        .doc('Q2IBBFqtB6y94Wfyj6zT')
        .collection('Measurement')
        .where("value", isEqualTo: "1")
        .get();
    // Get data from docs and convert map to List
    final allData_goodposture = querySnapshot_2.docs;
    int number_of_good = allData_goodposture.length;
    final allData = querySnapshot.docs;
    good_percent = number_of_good / allData.length;

    print(good_percent);
    for (var i = 0; i < allData.length; i++) {
      var dt = (allData[i]['Date_Time'].seconds) * 1000;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(dt);
      var sec1 = tsdate.hour * 60 * 60;
      var sec2 = tsdate.minute * 60;
      var sec3 = tsdate.second;
      var sec = sec1 + sec2 + sec3;
      list_points
          .add(FlSpot(sec.toDouble(), double.parse(allData[i]['value'])));
    }
    minX = list_points.first.x;
    maxX = list_points.last.x;
    print(list_points);
    print('--------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}
