import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/shared_components/app_drawer.dart';
import 'package:rayhan/components/shared_components/main_app_bar.dart';

import '../providers/theme_provider.dart';

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';

  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: getAppBar(
        title: 'عن التطبيق',
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0 *
            Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        child: Column(
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/icon/logodark.png'
                  : 'assets/icon/logo.png',
              height: 150.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
            SizedBox(
              height: 20.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
            Text(
              'يضم التطبيق مقتطفٌ يسير من الأذكار الواردة في السنة النبوية الشريفة من كتاب الأذكار للإمام النووي.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 25.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
                color: Theme.of(context).brightness == Brightness.dark
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
