import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TutorialSecondPage extends StatelessWidget {
  const TutorialSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'يمكنك تفعيل إشعارات للتذكير بأذكار الصباح والمساء من قائمة الإعدادات وتغيير حجم خط الأذكار وألوان التطبيق.',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize:
            25.0 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}
