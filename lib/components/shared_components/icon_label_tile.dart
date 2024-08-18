import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class IconLabelTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Widget endWidget;

  const IconLabelTile(
      {required this.label,
      required this.icon,
      required this.iconColor,
      required this.endWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          45.0 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 45.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
          SizedBox(
            width: 17.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 25.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          const Spacer(),
          endWidget,
        ],
      ),
    );
  }
}
