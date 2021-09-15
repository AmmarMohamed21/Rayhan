import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/services/settings.dart';

import '../constants.dart';

class AboutScreen extends StatelessWidget {
  static final String id = 'about_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Provider.of<Settings>(context).isNightTheme
          ? kNightBackgroundColor
          : kLightBackgroundColor,
      appBar: getAppBar(
        title: 'عن التطبيق',
        context: context,
      ),
    );
  }
}
