import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TutorialFourthPage extends StatelessWidget {
  const TutorialFourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'يرجى السماح باستخدام خاصية تحديد الموقع وخاصية إرسال الإشعارات.',
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
