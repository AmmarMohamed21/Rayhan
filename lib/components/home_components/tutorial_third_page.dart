import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/home_components/zikr_card_tutorial.dart';

import '../../providers/theme_provider.dart';

class TutorialThirdPage extends StatelessWidget {
  const TutorialThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'أثناء قراءة الأذكار اضغط على المربع المخصص للذكر لمتابعة العدد.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 22.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        ZikrCardTutorial(),
      ],
    );
  }
}
