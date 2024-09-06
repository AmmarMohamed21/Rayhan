import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';

import '../../providers/theme_provider.dart';

class FontSizeChoice extends StatelessWidget {
  const FontSizeChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white70
          : Colors.black54,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      selectedColor: kSecondaryColor,
      fillColor: Colors.transparent,
      renderBorder: false,
      onPressed: (int index) {
        Provider.of<SettingsProvider>(context, listen: false)
            .setIsFontMed(index == 0);
      },
      isSelected: [
        Provider.of<SettingsProvider>(context).isFontMed ?? true,
        !(Provider.of<SettingsProvider>(context).isFontMed ?? true)
      ],
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            'متوسط',
            style: TextStyle(
              fontSize: 25.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
          ),
        ),
        Text(
          'كبير',
          style: TextStyle(
            fontSize: 25.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
        ),
      ],
    );
  }
}
