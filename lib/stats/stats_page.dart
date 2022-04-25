import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';

class LineChartSample2 extends StatefulWidget {
  LineChartSample2({
    Key? key,
  }) : super(key: key);
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool showAvg = false;
  List<FlSpot> list_points = [];
  double minX = 0;
  double maxX = 24;
  double percent = 0;
  DateTime _selectedValue = DateTime.now();
  DateTime selectedValue_after = DateTime.now();
  double good_percent = 0;
  _fetch() async {
    list_points = [];
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
        list_points
            .add(FlSpot(sec.toDouble(), double.parse(allData[i]['value'])));
      }
      minX = list_points.first.x;
      maxX = list_points.last.x;
    } else {
      good_percent = 0;
    }

    print(list_points);
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
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        FlutterDatePickerTimeline(
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
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: width * 0.96,
                          margin: EdgeInsets.all(20.0),
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Good vs. Bad posture'),
                            SizedBox(
                              height: 10,
                            ),
                            new CircularPercentIndicator(
                              radius: 80.0,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 15.0,
                              percent: good_percent,
                              center: new Text(
                                (good_percent * 100).toStringAsFixed(2) + '%',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: Colors.red,
                              progressColor: Color(0xff67bd42),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width * 0.5,
                          child: Stack(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1.70,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(18),
                                      ),
                                      color: Color(0xff232d37)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 18.0,
                                        left: 12.0,
                                        top: 24,
                                        bottom: 12),
                                    child: LineChart(
                                      mainData(),
                                    ),
                                  ),
                                ),
                              ),
                              /* SizedBox(
                          width: 60,
                          height: 34,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                showAvg = !showAvg;
                              });
                            },
                            child: Text(
                              'avg',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: showAvg
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white),
                            ),
                          ),
                        ),*/
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
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

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Bad';
        break;
      case 1:
        text = 'Good';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: minX,
      maxX: maxX,
      minY: 0,
      maxY: 1,
      lineBarsData: [
        LineChartBarData(
          spots: list_points,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: minX,
      maxX: maxX,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: list_points,
          isCurved: false,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
