import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class ZikrCardContainer extends StatelessWidget {
  ZikrCardContainer({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20.0 * heightRatio),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Provider.of<Settings>(context).isNightTheme
                    ? Colors.white
                    : Provider.of<Settings>(context).isGreenTheme
                        ? kGreenPrimaryColor
                        : kBluePrimaryColor,
                fontSize: Provider.of<Settings>(context).isFontMed
                    ? 22.0 * heightRatio
                    : 26.0 * heightRatio,
              ),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.all(20 * heightRatio),
      decoration: BoxDecoration(
        color: Provider.of<Settings>(context).isNightTheme
            ? kNightBackgroundColor
            : kLightBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: !Provider.of<Settings>(context).isGreenTheme
                ? kBlueLightPrimaryColor
                : kGreenLightPrimaryColor,
            offset: Offset(0.0, 1.0),
            blurRadius: 3.0,
          ),
        ],
      ),
    );
  }
}
