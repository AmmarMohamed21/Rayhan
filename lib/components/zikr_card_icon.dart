import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class ZikrCardIcon extends StatelessWidget {
  ZikrCardIcon({
    this.isReversed = false,
  });

  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: isReversed ? Alignment.bottomLeft : Alignment.bottomRight,
        child: Transform(
          alignment: Alignment.center,
          transform:
              isReversed ? Matrix4.rotationY(math.pi) : Matrix4.rotationY(0.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 7.0 * sizeRatio),
            child: Icon(
              FontAwesomeIcons.pagelines,
              color: !Provider.of<Settings>(context).isGreenTheme
                  ? kBlueLightPrimaryColor
                  : kGreenLightPrimaryColor,
              size: 60.0 * sizeRatio,
            ),
          ),
        ),
      ),
    );
  }
}
