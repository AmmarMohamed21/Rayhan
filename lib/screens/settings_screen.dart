import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/custom_icons.dart';
import 'package:rayhan/components/font_size_choice.dart';
import 'package:rayhan/components/icon_label_tile.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/components/switch_notification_tile.dart';
import 'package:rayhan/components/theme_choice.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'azkar_screen';

  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: getAppBar(
        title: 'الإعدادات',
        context: context,
      ),
      body: SettingsRows(),
    );
  }
}

class SettingsRows extends StatelessWidget {
  const SettingsRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
          20.0 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
      child: ListView(
        children: [
          SwitchNotificationTile(
            label: 'إشعارات أذكار الصباح',
            icon: Icons.wb_sunny,
            iconColor: Colors.orangeAccent,
            isActive:
                Provider.of<SettingsProvider>(context).isSabahActive ?? false,
            isSabah: true,
          ),
          SizedBox(
            height: 20.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
          SwitchNotificationTile(
            label: 'إشعارات أذكار المساء',
            icon: CupertinoIcons.moon_fill,
            iconColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0xFF1d3557),
            isActive:
                Provider.of<SettingsProvider>(context).isMasaaActive ?? false,
            isSabah: false,
          ),
          SizedBox(
            height: 20.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
          IconLabelTile(
            label: 'حجم الخط',
            icon: CustomIcons.arabicfont,
            iconColor: Theme.of(context).primaryColor,
            endWidget: FontSizeChoice(),
          ),
          SizedBox(
            height: 20.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
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
      hours =
          Provider.of<SettingsProvider>(context, listen: false).sabahTime!.hour;
      minutes = Provider.of<SettingsProvider>(context, listen: false)
          .sabahTime!
          .minute;
    } else {
      hours =
          Provider.of<SettingsProvider>(context, listen: false).masaaTime!.hour;
      minutes = Provider.of<SettingsProvider>(context, listen: false)
          .masaaTime!
          .minute;
    }
    return '${addZeroToSingleDigit(getArabicNumber(hours))}:${addZeroToSingleDigit(getArabicNumber(minutes))}';
  }
}
