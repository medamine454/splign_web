import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splign_web/profile/components/accountbody.dart';

import '../../app/constans/enum.dart';
import '../../app/shared_components/coustom_bottom_nav_bar.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        backgroundColor: Color(0xff67bd42),
      ),
      body: AccountBody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
