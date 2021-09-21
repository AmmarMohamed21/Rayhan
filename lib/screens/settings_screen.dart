import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/custom_icons.dart';
import 'package:rayhan/components/font_size_choice.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/components/icon_label_tile.dart';

import 'package:rayhan/components/switch_notification_tile.dart';
import 'package:rayhan/components/theme_choice.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';
import 'package:rayhan/services/settings.dart';

class SettingsScreen extends StatelessWidget {
  static final String id = 'azkar_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Provider.of<Settings>(context).isNightTheme
          ? kNightBackgroundColor
          : kLightBackgroundColor,
      appBar: getAppBar(
        title: 'الإعدادات',
        context: context,
      ),
      body: SettingsRows(),
    );
  }
}

class SettingsRows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0 * heightRatio),
      child: ListView(
        children: [
          SwitchNotificationTile(
            label: 'إشعارات أذكار الصباح',
            icon: Icons.wb_sunny,
            iconColor: Colors.orangeAccent,
            isActive:
                Provider.of<Settings>(context, listen: false).isSabahActive,
            isSabah: true,
          ),
          SwitchNotificationTile(
            label: 'إشعارات أذكار المساء',
            icon: CupertinoIcons.moon_fill,
            iconColor: Provider.of<Settings>(context).isNightTheme
                ? Colors.white
                : Color(0xFF1d3557),
            isActive:
                Provider.of<Settings>(context, listen: false).isMasaaActive,
            isSabah: false,
          ),
          IconLabelTile(
            label: 'حجم الخط',
            icon: CustomIcons.arabicfont,
            iconColor: Provider.of<Settings>(context).isGreenTheme
                ? kGreenLightPrimaryColor
                : kBlueLightPrimaryColor,
            endWidget: FontSizeChoice(),
          ),
          IconLabelTile(
            label: 'ألوان التطبيق',
            icon: Icons.color_lens,
            iconColor: kSecondaryColor,
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
