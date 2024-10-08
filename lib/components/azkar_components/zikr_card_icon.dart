import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

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
            padding: EdgeInsets.only(
                bottom: 7.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio),
            child: Icon(
              FontAwesomeIcons.pagelines,
              color: Theme.of(context).primaryColor,
              size: 60.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
          ),
        ),
      ),
    );
  }
}
