import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/constans/enum.dart';
import '../../app/shared_components/coustom_bottom_nav_bar.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xff67bd42),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:ListView(
            children: [ SettingsGroup(
          items: [
            SettingsItem(
              onTap: () {},
              icons: CupertinoIcons.pencil_outline,
              iconStyle: IconStyle(),
              title: 'Appearance',
              subtitle: "Make splign App yours",
            ),
            SettingsItem(
              onTap: () {},
              icons: Icons.dark_mode_rounded,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Dark mode',
              subtitle: "Automatic",
              trailing: Switch.adaptive(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      SettingsGroup(
        items: [
          SettingsItem(
            onTap: () {},
            icons: Icons.info_rounded,
            iconStyle: IconStyle(
              backgroundColor: Colors.purple,
            ),
            title: 'About',
            subtitle: "Learn more about Splign App",
          ),
        ],

      ),
           SettingsGroup(
    settingsGroupTitle: "Account",
    items: [
    SettingsItem(
    onTap: () {},
    icons: CupertinoIcons.delete_solid,
    title: "Delete account",
    titleStyle: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    ),
    ),]
    ),
    ],
    ),

    ),

      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}