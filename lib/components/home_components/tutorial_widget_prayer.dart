import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class TutorialWidgetPrayer extends StatelessWidget {
  const TutorialWidgetPrayer({
    super.key,
    required this.icon,
    required this.name,
    required this.color,
  });

  final IconData icon;
  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: MediaQuery.of(context).size.width * 0.05,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
