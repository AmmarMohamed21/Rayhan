import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/services/settings.dart';

class FontSizeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      color: Provider.of<Settings>(context).isNightTheme
          ? Colors.white70
          : Colors.black54,
      selectedColor: kSecondaryColor,
      fillColor: Provider.of<Settings>(context).isNightTheme
          ? kNightBackgroundColor
          : kLightBackgroundColor,
      renderBorder: false,
      children: [
        Text(
          'متوسط',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        Text(
          'كبير',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ],
      onPressed: (int index) {
        Provider.of<Settings>(context, listen: false).setFontSize(index);
      },
      isSelected: [
        Provider.of<Settings>(context).isFontMed,
        !Provider.of<Settings>(context).isFontMed
      ],
    );
  }
}
