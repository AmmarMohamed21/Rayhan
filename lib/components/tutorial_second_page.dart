import 'package:flutter/material.dart';
import 'package:rayhan/utilities/constants.dart';

class TutorialSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'يمكنك تفعيل إشعارات للتذكير بأذكار الصباح والمساء من قائمة الإعدادات وتغيير حجم خط الأذكار وألوان التطبيق.',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 25.0 * heightRatio,
      ),
    );
  }
}
