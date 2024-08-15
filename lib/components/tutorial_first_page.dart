import 'package:flutter/material.dart';
import 'package:rayhan/utilities/constants.dart';

class TutorialFirstPage extends StatelessWidget {
  const TutorialFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'يضم التطبيق مقتطفٌ يسير من الأذكار الواردة في السنة النبوية الشريفة من كتاب الأذكار للإمام النووي.',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 25.0 * sizeRatio,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}
