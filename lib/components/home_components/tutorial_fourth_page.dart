import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import 'home_widget_tutorial.dart';

class TutorialFourthPage extends StatelessWidget {
  const TutorialFourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'يمكنك إضافة مواقيت الصلاة إلى الصفحة الرئيسية لهاتفك.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 22.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        HomeWidgetTutorial(),
      ],
    );
  }
}
