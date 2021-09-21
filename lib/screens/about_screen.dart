import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/services/settings.dart';

import '../utilities/constants.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              Provider.of<Settings>(context).isNightTheme
                  ? 'assets/icon/logodark.png'
                  : 'assets/icon/logo.png',
              height: 150.0 * heightRatio * widthRatio,
            ),
            SizedBox(
              height: 20.0 * heightRatio,
            ),
            Text(
              'يضم التطبيق مقتطفٌ يسير من الأذكار الواردة في السنة النبوية الشريفة من كتاب الأذكار للإمام النووي.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 25.0 * heightRatio * widthRatio,
                color: Provider.of<Settings>(context).isNightTheme
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
