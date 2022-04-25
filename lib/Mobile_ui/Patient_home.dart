import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepatient extends StatefulWidget {
  const Homepatient({Key? key}) : super(key: key);
  @override
  _HomepatientState createState() => _HomepatientState();
}

class _HomepatientState extends State<Homepatient> {
  int selectedDelay = 5;
  void changedelay(int type) {
    selectedDelay = type;
    setState(() {});
  }

  int _dropDownValue = 5;
  int _dropDownValue_min = 15;
  var cancel_start = true;
  Timer _timer =
      Timer(const Duration(seconds: 5), () => print('Timer finished'));
  int seconds = 120;
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) +
        ":" +
        formatTime(minute) +
        ":" +
        formatTime(second);
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  int x = 1;
  String anim = 'anim';
  int mqtt = 0;
  int time_delay = 12;
  int time_goal = 60;
  Color progre_color = Color(0xff67bd42);
  @override
  void initState() {
    if (mqtt == 1) {
      anim = 'anim';
      progre_color = Color(0xff67bd42);
    } else {
      anim = 'reversed';
      progre_color = Colors.red;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Tracking',
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xff67bd42),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(children: [
            SizedBox(
              width: 15,
            ),
            Text(
              'Good morning Ahmed !',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Center(
              child: RichText(
            text: TextSpan(children: [
              WidgetSpan(child: Icon(Icons.timelapse_sharp, size: 21)),
              TextSpan(
                text: 'Time remaining : ',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 20,
                  color: Color(0xff67bd42),
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                  text: constructTime(seconds),
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
            ]),
          )),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/$anim.gif',
                  height: 200,
                ),
              ),
              Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12,
                  percent: ((seconds / 120) - 1).abs(),
                  progressColor: progre_color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(child: Text("Choose your goal")),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              actionsOverflowButtonSpacing: 20,
                              content: Container(
                                  child: DropdownButton(
                                hint: Text('$_dropDownValue_min minutes'),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.blue),
                                items: [15, 30, 60].map(
                                  (val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text('$val minutes'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _dropDownValue_min = val as int;
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              )),
                            );
                          });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.bullseye,
                      size: 30,
                      color: Color(0xff67bd42),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ToggleSwitch(
                    minWidth: 55.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Color(0xff67bd42)],
                      [Colors.red[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: ['On', 'Off'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                  child: Text("Choose your delay response")),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              actionsOverflowButtonSpacing: 20,
                              content: Container(
                                  child: DropdownButton(
                                hint: Text('$_dropDownValue seconds'),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.blue),
                                items: [5, 15, 30].map(
                                  (val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text('$val seconds'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _dropDownValue = val as int;
                                      Navigator.pop(context);
                                      print(_dropDownValue);
                                    },
                                  );
                                },
                              )),
                            );
                          });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.stopwatch,
                      size: 30,
                      color: Color(0xff67bd42),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Goal',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Notifications',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Delay',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$_dropDownValue_min min',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '                         ',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '$_dropDownValue sec',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 17,
                  color: Color.fromARGB(255, 49, 49, 49),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          _submitButton(),
          _canceltButton()
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Visibility(
      visible: cancel_start,
      child: InkWell(
        onTap: () {
          setState(() {
            cancel_start = !cancel_start;
          });
          startTimer();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
          child: Text('Start Posture Tracking',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _canceltButton() {
    return Visibility(
      visible: !cancel_start,
      child: InkWell(
        onTap: () {
          setState(() {
            cancel_start = !cancel_start;
          });
          cancelTimer();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
              color: Colors.red),
          child: Text('Pause Posture Tracking',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}
