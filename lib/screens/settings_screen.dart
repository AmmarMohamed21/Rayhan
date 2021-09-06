import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/custom_icons.dart';
import 'package:rayhan/components/font_size_choice.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/components/setting_row.dart';
import 'package:rayhan/components/theme_choice.dart';
import 'package:rayhan/constants.dart';
import 'package:rayhan/services/helper.dart';
import 'package:rayhan/services/settings.dart';
import '../components/notificaton_switch.dart';
import 'dart:math' as math;

class SettingsScreen extends StatelessWidget {
  static final String id = 'azkar_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<Settings>(context).isNightTheme
          ? Color(0xFF202020)
          : Colors.grey[50],
      appBar: getAppBar(title: 'الإعدادات', context: context),
      body: SettingsRows(
          //sabahNotify: prefs.getBool(''),
          ),
    );
  }
}

class SettingsRows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView(
        children: [
          NotificationSwitch(
            isActive:
                Provider.of<Settings>(context, listen: false).isSabahActive,
            title: 'إشعارات أذكار الصباح',
            icon: Icons.wb_sunny,
            iconColor: Colors.orangeAccent,
          ),
          NotificationSwitch(
            isActive:
                Provider.of<Settings>(context, listen: false).isMasaaActive,
            title: 'إشعارات أذكار المساء',
            icon: CupertinoIcons.moon_fill,
            iconColor: Provider.of<Settings>(context).isNightTheme
                ? Colors.white
                : Color(0xFF1d3557), //hereeee
          ),
          SettingRow(
            label: 'حجم الخط',
            icon: MyFlutterApp.arabicfont,
            iconColor: Provider.of<Settings>(context).isGreenTheme
                ? kGreenLightPrimaryColor
                : kBlueLightPrimaryColor, //hereeee
            endWidget: FontSizeChoice(),
          ),
          SettingRow(
            label: 'ألوان التطبيق',
            icon: Icons.color_lens,
            iconColor: kSecondaryColor, //hereeee
            endWidget: ThemeChoice(),
          ),
        ],
      ),
    );
  }

  String getSubtitle(BuildContext context, String title) {
    int hours;
    int minutes;
    if (title == 'إشعارات أذكار الصباح') {
      hours = Provider.of<Settings>(context, listen: false).sabahHours;
      minutes = Provider.of<Settings>(context, listen: false).sabahMinutes;
    } else {
      hours = Provider.of<Settings>(context, listen: false).masaaHours;
      minutes = Provider.of<Settings>(context, listen: false).masaaMinutes;
    }
    return addZeroToSingleDigit(getArabicNumber(hours)) +
        ':' +
        addZeroToSingleDigit(getArabicNumber(minutes));
  }
}
