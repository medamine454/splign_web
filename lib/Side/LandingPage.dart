import 'package:flutter/material.dart';
import 'package:splign_web/Side/pages/AboutPage.dart';
import 'package:splign_web/Side/pages/HelpPage.dart';
import 'package:splign_web/Side/pages/List_patients_stream.dart';
import 'package:splign_web/Side/pages/ProfilePage.dart';
import 'package:splign_web/Side/pages/SettingsPage.dart';
import 'package:splign_web/Side/pages/User_profile.dart';
import 'package:splign_web/Side/pages/graph2.dart';
import 'package:splign_web/Side/pages/graph_stream.dart';
import 'package:splign_web/profile/edit/build_stream_foredit.dart';
import '../profile/edit/build_stream_ptofil.dart';
import 'pages/graph.dart';

class LandingPage extends StatefulWidget {
  final String page;
  final String extra;

  const LandingPage({Key? key, required this.page, required this.extra})
      : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

List<String> pages = [
  'home',
  'about',
  'profile',
  'settings',
  'help',
];

List<String> main_pages = [
  'Patients',
  'Profile',
  'Settings',
];

List<IconData> icons = [
  Icons.person_add,
  Icons.person,
  Icons.settings,
];

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: icons.map((e) {
                  return NavItem(
                    name: main_pages[icons.indexOf(e)],
                    selected: icons.indexOf(e) == pages.indexOf(widget.page),
                    icon: e,
                    onTap: () {
                      if (icons.indexOf(e) == 1) {
                        Navigator.pushNamed(
                            context, '/main/${pages[icons.indexOf(e)]}/Scott');
                      } else {
                        Navigator.pushNamed(
                            context, '/main/${pages[icons.indexOf(e)]}');
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: IndexedStack(
                  index: pages.indexOf(widget.page),
                  children: [
                    ListpatientStream(),
                    ChartStream(),
                    EditProfilePgg(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final Function onTap;
  final String name;

  const NavItem(
      {Key? key,
      required this.icon,
      required this.selected,
      required this.onTap,
      required this.name})
      : super(key: key);
  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Center(
          child: AnimatedContainer(
              duration: Duration(milliseconds: 375),
              width: double.infinity,
              height: 60.0,
              color: widget.selected ? Colors.green : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.selected ? Colors.white : Colors.black87,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: widget.selected ? Colors.white : Colors.black87,
                        fontSize: 18),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}


/// u can see the url is not working perfectly.....ryt?
/// this flutter beta is not working fine....
/// for u to see this working fine...
/// run in release mode... 
/// will show u how to do that....
/// 
/// thats it.... u can do the same... to see the perfect output... or else u can change the flutter channel to dev....
/// its working fine in dev channel.... 
/// 
/// :)