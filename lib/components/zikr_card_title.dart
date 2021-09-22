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
          padding: EdgeInsets.symmetric(horizontal: 25.0 * sizeRatio),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0 * sizeRatio),
            color: Provider.of<Settings>(context, listen: false).isNightTheme
                ? kNightBackgroundColor
                : kLightBackgroundColor,
            child: Text(
              title,
              style: TextStyle(
                fontSize: Provider.of<Settings>(context).isFontMed
                    ? 25 * sizeRatio
                    : 28 * sizeRatio,
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
