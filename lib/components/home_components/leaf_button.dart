import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/screens/azkar_screen.dart';

import '../../providers/theme_provider.dart';
import '../../screens/prayer_times_screen.dart';
import '../custom_icons.dart';

class LeafButton extends StatelessWidget {
  final String label;
  final bool isInverse;
  final int position;
  const LeafButton(
      {super.key,
      required this.label,
      required this.isInverse,
      required this.position});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromRGBO(45, 45, 45, 0.2)
          : const Color.fromRGBO(215, 215, 215, 0.2),
      splashColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromRGBO(45, 45, 45, 0.2)
          : const Color.fromRGBO(215, 215, 215, 0.2),
      borderRadius: BorderRadius.circular(
          80.0 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
      onTap: () {
        if (label != 'مواقيت الصلاة') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AzkarScreen(
                title: label,
              ),
            ),
          );
        } else {
          Navigator.pushNamed(context, PrayerTimesScreen.id);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isInverse ? math.pi : 0),
            child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: position == 0
                      ? [
                          Theme.of(context).primaryColorLight.withOpacity(0.75),
                          Theme.of(context).primaryColor,
                        ]
                      : position == 1
                          ? [
                              Theme.of(context).primaryColorLight,
                              Theme.of(context).primaryColor
                            ]
                          : [
                              Theme.of(context).primaryColorLight,
                              Theme.of(context).primaryColorDark,
                            ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: Icon(
                CustomIcons.leaf,
                color: Colors.white,
                size: 160.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
              ),
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
          ),
        ],
      ),
    );
  }
}
