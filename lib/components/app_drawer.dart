import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      width: 200.0 * widthRatio,
      child: Drawer(
        child: Container(
          color: Provider.of<Settings>(context, listen: false).isNightTheme
              ? kNightBackgroundColor
              : kLightBackgroundColor,
          child: ListView(
            children: [
              DrawerHeader(
                margin: EdgeInsets.only(bottom: 8.0 * widthRatio),
                padding: EdgeInsets.fromLTRB(
                  16.0 * widthRatio,
                  16.0 * widthRatio,
                  16.0 * widthRatio,
                  8.0 * widthRatio,
                ),
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
                icon: FontAwesomeIcons.pagelines,
                onTap: () {
                  Navigator.pop(context);
                  if (ModalRoute.of(context).settings.name != HomeScreen.id)
                    Navigator.popUntil(
                        context, ModalRoute.withName(HomeScreen.id));
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
