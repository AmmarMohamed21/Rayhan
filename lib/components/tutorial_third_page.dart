import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/zikr_card_tutorial.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class TutorialThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'أثناء قراءة الأذكار اضغط على المربع المخصص للذكر لاحتساب العدد.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 22.0 * sizeRatio,
            color: Provider.of<Settings>(context).isNightTheme
                ? Colors.white
                : Colors.black,
          ),
        ),
        ZikrCardTutorial(),
      ],
    );
  }
}
