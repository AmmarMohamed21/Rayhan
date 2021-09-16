import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/screens/about_screen.dart';
import 'package:rayhan/screens/home_screen.dart';
import 'package:rayhan/screens/prayer_times_screen.dart';
import 'package:rayhan/screens/settings_screen.dart';
import 'package:rayhan/services/settings.dart';

import '../utilities/constants.dart';
import 'drawer_list_tile.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      child: Drawer(
        child: Container(
          color: Provider.of<Settings>(context, listen: false).isNightTheme
              ? kNightBackgroundColor
              : kLightBackgroundColor,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color:
                      Provider.of<Settings>(context, listen: false).isNightTheme
                          ? kNightBackgroundColor
                          : kLightBackgroundColor,
                ),
                child:
                    Provider.of<Settings>(context, listen: false).isNightTheme
                        ? Image.asset('assets/icon/logodark.png')
                        : Image.asset('assets/icon/logo.png'),
              ),
              DrawerListTile(
                label: 'الأذكار',
                onTap: () {
                  Navigator.pop(context);
                  if (ModalRoute.of(context).settings.name != HomeScreen.id)
                    Navigator.popUntil(
                        context, ModalRoute.withName(HomeScreen.id));
                },
              ),
              DrawerListTile(
                label: 'مواقيت الصلاة',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, PrayerTimesScreen.id);
                },
              ),
              DrawerListTile(
                label: 'الإعدادات',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingsScreen.id);
                },
              ),
              DrawerListTile(
                label: 'عن التطبيق',
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
