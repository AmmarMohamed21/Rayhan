import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class ZikrCardTitle extends StatelessWidget {
  ZikrCardTitle({
    this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            color: Provider.of<Settings>(context, listen: false).isNightTheme
                ? kNightBackgroundColor
                : kLightBackgroundColor,
            child: Text(
              title,
              style: TextStyle(
                fontSize: Provider.of<Settings>(context).isFontMed ? 25 : 28,
                color: Provider.of<Settings>(context).isNightTheme
                    ? Colors.white
                    : Provider.of<Settings>(context).isGreenTheme
                        ? kGreenPrimaryColor
                        : kBluePrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
