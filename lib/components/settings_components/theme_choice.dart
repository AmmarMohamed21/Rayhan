import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/theme_provider.dart';

import '../../utilities/constants.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ThemeChoiceButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme(false, false, context);
          },
          isSelected: !(Provider.of<ThemeProvider>(context, listen: false)
                      .isAutoTheme ??
                  false) &&
              !(Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkTheme ??
                  false),
          label: 'مُضيء',
          icon: Icons.light_mode_outlined,
          iconColor: Colors.amberAccent,
        ),
        SizedBox(
            width: 15.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        ThemeChoiceButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme(false, true, context);
          },
          isSelected: !(Provider.of<ThemeProvider>(context, listen: false)
                      .isAutoTheme ??
                  false) &&
              (Provider.of<ThemeProvider>(context, listen: false).isDarkTheme ??
                  false),
          label: 'خافت',
          icon: Icons.dark_mode_outlined,
          iconColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0xFF1d3557),
        ),
        SizedBox(
            width: 15.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        ThemeChoiceButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme(true, false, context);
          },
          isSelected:
              Provider.of<ThemeProvider>(context, listen: false).isAutoTheme ??
                  false,
          label: 'تلقائي',
          icon: Icons.brightness_4_outlined,
          iconColor: Colors.blue,
        ),
      ],
    );
  }
}

class ThemeChoiceButton extends StatelessWidget {
  const ThemeChoiceButton({
    super.key,
    required this.onPressed,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  final void Function() onPressed;
  final bool isSelected;
  final String label;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 30.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
          SizedBox(height: 5.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
              color: isSelected
                  ? kSecondaryColor
                  : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
