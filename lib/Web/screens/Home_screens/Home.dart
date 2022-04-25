import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splign_web/Web/screens/Home_screens/First.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  int selectedPage = 0;
  final _pageOptions = [
    First_web(),
    First_web(),
    First_web(),
    First_web(),
  ];
  void onPageChanged(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _pageOptions,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      /*_pageOptions[selectedPage],*/
      bottomNavigationBar: ConvexAppBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        activeColor: Color(0xff67bd42),
        //cornerRadius: 30,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.query_stats, title: 'Stats'),
          TabItem(icon: Icons.medical_services, title: 'My doctor'),
          TabItem(icon: Icons.help, title: 'Support'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: selectedPage, //optional, default as 0
        onTap: (int index) {
          setState(() {
            //selectedPage = index;
            pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
