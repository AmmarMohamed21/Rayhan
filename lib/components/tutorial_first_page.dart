import 'package:flutter/material.dart';

class TutorialFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'يضم التطبيق مقتطفٌ يسير من الأذكار الواردة في السنة النبوية الشريفة من كتاب الأذكار للإمام النووي.',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 25.0,
      ),
    );
  }
}
