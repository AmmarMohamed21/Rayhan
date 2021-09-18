import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/screens/azkar_screen.dart';
import 'package:rayhan/screens/settings_screen.dart';
import 'package:rayhan/services/settings.dart';
import 'dart:math' as math;
import 'custom_icons.dart';
import 'package:rayhan/utilities/constants.dart';

class LeafButton extends StatelessWidget {
  final String label;
  final bool isInversed;
  LeafButton({this.label, this.isInversed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Provider.of<Settings>(context, listen: false).isNightTheme
          ? Color.fromRGBO(45, 45, 45, 0.2)
          : Color.fromRGBO(215, 215, 215, 0.2),
      splashColor: Provider.of<Settings>(context, listen: false).isNightTheme
          ? Color.fromRGBO(45, 45, 45, 0.2)
          : Color.fromRGBO(215, 215, 215, 0.2),
      borderRadius: BorderRadius.circular(80),
      onTap: () {
        if (label != 'الإعدادات') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AzkarScreen(
                title: label,
              ),
            ),
          );
        } else {
          Navigator.pushNamed(context, SettingsScreen.id);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isInversed ? math.pi : 0),
            child: Icon(
              CustomIcons.leaf,
              color: Provider.of<Settings>(context, listen: false).isGreenTheme
                  ? kGreenLightPrimaryColor
                  : kBlueLightPrimaryColor,
              size: 160.0,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
