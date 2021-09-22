import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

class ZikrCardCounter extends StatelessWidget {
  ZikrCardCounter({
    this.number,
  });

  final int number;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 45.0 * sizeRatio,
          height: 45.0 * sizeRatio,
          decoration: BoxDecoration(
            color: Provider.of<Settings>(context).isNightTheme
                ? kNightBackgroundColor
                : Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.circular(45.0 * sizeRatio),
            boxShadow: [
              BoxShadow(
                color: !Provider.of<Settings>(context).isGreenTheme
                    ? kBlueLightPrimaryColor
                    : kGreenLightPrimaryColor,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0 * sizeRatio,
              ),
            ],
          ),
          child: Center(
            child: Text(
              getArabicNumber(number),
              style: TextStyle(
                fontSize: 30.0 * sizeRatio,
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
