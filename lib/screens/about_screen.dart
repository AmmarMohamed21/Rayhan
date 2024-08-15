import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/providers/settings_provider.dart';

import '../utilities/constants.dart';

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';

  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      // backgroundColor: Provider.of<SettingsProvider>(context).isNightTheme
      //     ? kDarkBackgroundColor
      //     : kLightBackgroundColor,
      appBar: getAppBar(
        title: 'عن التطبيق',
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0 * sizeRatio),
        child: Column(
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/icon/logodark.png'
                  : 'assets/icon/logo.png',
              height: 150.0 * sizeRatio,
            ),
            SizedBox(
              height: 20.0 * sizeRatio,
            ),
            Text(
              'يضم التطبيق مقتطفٌ يسير من الأذكار الواردة في السنة النبوية الشريفة من كتاب الأذكار للإمام النووي.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 25.0 * sizeRatio,
                color:  Theme.of(context).brightness == Brightness.dark
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
