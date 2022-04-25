import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:splign_web/Side/pages/graph.dart';
import 'package:splign_web/Side/pages/graph2.dart';

class ChartStream extends StatefulWidget {
  ChartStream({
    Key? key,
  }) : super(key: key);
  @override
  _ChartStreamState createState() => _ChartStreamState();
}

class _ChartStreamState extends State<ChartStream> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool showAvg = false;
  List<ChartData> data_points1 = [];
  List<String> list_points_x = [];
  List<double> list_points_y = [];
  double minX = 0;
  double maxX = 24;
  double percent = 0;
  DateTime _selectedValue = DateTime.now();
  DateTime selectedValue_after = DateTime.now();
  double good_percent = 0;
  _fetch() async {
    print(_selectedValue);

    data_points1 = [];
    good_percent = 0;
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc('ADbyzv77pPeOtxwf3ai7JMdEho82')
        .collection('Gadget')
        .doc('Q2IBBFqtB6y94Wfyj6zT')
        .collection('Measurement');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc('ADbyzv77pPeOtxwf3ai7JMdEho82')
        .collection('Gadget')
        .doc('Q2IBBFqtB6y94Wfyj6zT')
        .collection('Measurement')
        .where("Date_Time", isGreaterThanOrEqualTo: _selectedValue)
        .where("Date_Time", isLessThanOrEqualTo: selectedValue_after)
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

    print(good_percent);

    if (allData.length > 0) {
      good_percent = number_of_good / allData.length;
      for (var i = 0; i < allData.length; i++) {
        var dt = (allData[i]['Date_Time'].seconds) * 1000;
        DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(dt);
        var sec1 = tsdate.hour * 60 * 60;
        var sec2 = tsdate.minute * 60;
        var sec3 = tsdate.second;
        var sec = sec1 + sec2 + sec3;
        String ch = tsdate.hour.toString() +
            ':' +
            tsdate.minute.toString() +
            ':' +
            tsdate.second.toString();
        data_points1.add(ChartData(ch, double.parse(allData[i]['value'])));
        //  list_points_y.add(double.parse(allData[i]['value']));
        // list_points_x.add(sec.toString());
        /*  if (sec == 0) {
          list_points_x.add('00:00');
        } else if (sec == 3600) {
          list_points_x.add('02:00');
        } else if (sec == 7200) {
          list_points_x.add('03:00');
        } else if (sec == 10800) {
          list_points_x.add('04:00');
        } else if (sec == 14400) {
          list_points_x.add('05:00');
        } else if (sec == 18000) {
          list_points_x.add('06:00');
        } else if (sec == 21600) {
          list_points_x.add('07:00');
        } else if (sec == 25200) {
          list_points_x.add('08:00');
        } else if (sec == 28800) {
          list_points_x.add('09:00');
        } else if (sec == 32400) {
          list_points_x.add('10:00');
        } else if (sec == 36000) {
          list_points_x.add('11:00');
        } else if (sec == 39600) {
          list_points_x.add('12:00');
        } else if (sec == 43200) {
          list_points_x.add('13:00');
        } else if (sec == 46800) {
          list_points_x.add('14:00');
        } else if (sec == 50400) {
          list_points_x.add('15:00');
        } else if (sec == 54000) {
          list_points_x.add('16:00');
        } else if (sec == 57600) {
          list_points_x.add('17:00');
        } else if (sec == 61200) {
          list_points_x.add('17:00');
        } else if (sec == 64800) {
          list_points_x.add('18:00');
        } else if (sec == 68400) {
          list_points_x.add('19:00');
        } else if (sec == 72000) {
          list_points_x.add('20:00');
        } else if (sec == 75600) {
          list_points_x.add('21:00');
        } else if (sec == 79200) {
          list_points_x.add('22:00');
        } else if (sec == 82800) {
          list_points_x.add('23:00');
        } else {
          list_points_x.add('');
        }*/
      }
      // minX = list_points.first.x;
      //  maxX = list_points.last.x;
    } else {
      good_percent = 0;
    }

    print(list_points_x);
    print(list_points_y);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final Scaffold scaffold = Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Statistics',
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff67bd42),
        ),
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.7,
                        child: FlutterDatePickerTimeline(
                          startDate: DateTime(2022, 03, 01),
                          endDate: DateTime.now(),
                          selectedItemBackgroundColor: Color(0xff67bd42),
                          unselectedItemBackgroundColor:
                              Color.fromARGB(255, 255, 255, 255),
                          initialSelectedDate: _selectedValue,
                          onSelectedDateChange: (dateTime) {
                            setState(() {
                              _selectedValue = dateTime!;
                              selectedValue_after =
                                  _selectedValue.add(new Duration(days: 1));
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Graphic(data_points: data_points1),

                      /*  GraphScreen(
                        data_x: list_points_x,
                        data_y: list_points_y,
                      )*/
                    ],
                  ),
                );
              }
            }));

    return scaffold;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('00:00', style: style);
        break;
      case 3600:
        text = const Text('01:00', style: style);
        break;
      case 7200:
        text = const Text('02:00', style: style);
        break;
      case 10800:
        text = const Text('03:00', style: style);
        break;
      case 14400:
        text = const Text('04:00', style: style);
        break;
      case 18000:
        text = const Text('05:00', style: style);
        break;
      case 21600:
        text = const Text('06:00', style: style);
        break;
      case 25200:
        text = const Text('07:00', style: style);
        break;
      case 28800:
        text = const Text('08:00', style: style);
        break;
      case 32400:
        text = const Text('09:00', style: style);
        break;
      case 36000:
        text = const Text('10:00', style: style);
        break;
      case 39600:
        text = const Text('11:00', style: style);
        break;
      case 43200:
        text = const Text('12:00', style: style);
        break;
      case 46800:
        text = const Text('13:00', style: style);
        break;
      case 50400:
        text = const Text('14:00', style: style);
        break;
      case 54000:
        text = const Text('15:00', style: style);
        break;
      case 57600:
        text = const Text('16:00', style: style);
        break;
      case 61200:
        text = const Text('17:00', style: style);
        break;
      case 64800:
        text = const Text('18:00', style: style);
        break;
      case 68400:
        text = const Text('19:00', style: style);
        break;
      case 72000:
        text = const Text('20:00', style: style);
        break;
      case 82800:
        text = const Text('23:00', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }
}
