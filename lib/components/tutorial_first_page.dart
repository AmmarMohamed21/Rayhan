import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class TutorialFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'يضم التطبيق مقتطفٌ يسير من الأذكار الواردة في السنة النبوية الشريفة من كتاب الأذكار للإمام النووي.',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 25.0 * sizeRatio,
        color: Provider.of<Settings>(context).isNightTheme
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}
