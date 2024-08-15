import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayhan/screens/about_screen.dart';
import 'package:rayhan/screens/home_screen.dart';
import 'package:rayhan/screens/prayer_times_screen.dart';
import 'package:rayhan/screens/settings_screen.dart';

import '../utilities/constants.dart';
import 'drawer_list_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0 * sizeRatio,
      child: Drawer(
        child: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? kDarkBackgroundColor
              : kLightBackgroundColor,
          child: ListView(
            children: [
              Container(
                constraints: BoxConstraints(
                    minHeight: 175.0 * sizeRatio, maxHeight: 175.0 * sizeRatio),
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? kDarkBackgroundColor
                        : kLightBackgroundColor,
                  ),
                  child: Theme.of(context).brightness == Brightness.dark
                      ? Image.asset(
                          'assets/icon/logodark.png',
                        )
                      : Image.asset(
                          'assets/icon/logo.png',
                        ),
                ),
              ),
              DrawerListTile(
                label: 'الأذكار',
                icon: FontAwesomeIcons.pagelines,
                onTap: () {
                  Navigator.pop(context);
                  if (ModalRoute.of(context)?.settings.name != HomeScreen.id) {
                    Navigator.popUntil(
                        context, ModalRoute.withName(HomeScreen.id));
                  }
                },
              ),
              DrawerListTile(
                label: 'مواقيت الصلاة',
                icon: Icons.access_time,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, PrayerTimesScreen.id);
                },
              ),
              DrawerListTile(
                label: 'الإعدادات',
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingsScreen.id);
                },
              ),
              DrawerListTile(
                label: 'عن التطبيق',
                icon: Icons.info_outline,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
