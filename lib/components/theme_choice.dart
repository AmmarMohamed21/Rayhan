import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/constants.dart';
import 'package:rayhan/services/settings.dart';
import 'dart:math' as math;

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<Settings>(context).isGreenTheme &&
                    !Provider.of<Settings>(context).isNightTheme
                ? 25.0
                : 22,
            backgroundColor: Provider.of<Settings>(context).isGreenTheme &&
                    !Provider.of<Settings>(context).isNightTheme
                ? kSecondaryColor
                : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kGreenLightPrimaryColor,
              lowerColor: kLightBackgroundColor,
              diameter: Provider.of<Settings>(context).isGreenTheme &&
                      !Provider.of<Settings>(context).isNightTheme
                  ? 44
                  : 40,
            ),
          ),
          onTap: () {
            Provider.of<Settings>(context, listen: false).setGreenTheme();
          },
        ),
        SizedBox(
          width: 5.0,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: !Provider.of<Settings>(context).isGreenTheme ? 25 : 22.0,
            backgroundColor: !Provider.of<Settings>(context).isGreenTheme
                ? kSecondaryColor
                : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kBlueLightPrimaryColor,
              lowerColor: kLightBackgroundColor,
              diameter: !Provider.of<Settings>(context).isGreenTheme ? 44 : 40,
            ),
          ),
          onTap: () {
            Provider.of<Settings>(context, listen: false).setBlueTheme();
          },
        ),
        SizedBox(
          width: 5.0,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<Settings>(context).isNightTheme ? 25 : 22.0,
            backgroundColor: Provider.of<Settings>(context).isNightTheme
                ? kSecondaryColor
                : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kGreenLightPrimaryColor,
              lowerColor: Color.fromRGBO(40, 40, 40, 1),
              diameter: Provider.of<Settings>(context).isNightTheme ? 44 : 40,
            ),
          ),
          onTap: () {
            Provider.of<Settings>(context, listen: false).setNightTheme();
          },
        ),
      ],
    );
  }
}

class TwoColouredCircle extends StatelessWidget {
  final Color upperColor;
  final Color lowerColor;
  final double diameter;
  TwoColouredCircle({this.upperColor, this.lowerColor, this.diameter = 38});

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

class SemiCircle extends CustomPainter {
  final Color color;
  SemiCircle({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
