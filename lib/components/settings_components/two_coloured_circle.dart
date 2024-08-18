import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'semi_circle.dart';

class TwoColouredCircle extends StatelessWidget {
  final Color upperColor;
  final Color lowerColor;
  final double diameter;
  const TwoColouredCircle(
      {super.key,
      required this.upperColor,
      required this.lowerColor,
      required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: SemiCircle(color: upperColor),
          size: Size(diameter, diameter),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(math.pi),
          child: CustomPaint(
            painter: SemiCircle(color: lowerColor),
            size: Size(diameter, diameter),
          ),
        ),
      ],
    );
  }
}
