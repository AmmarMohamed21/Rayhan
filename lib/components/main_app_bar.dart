import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayhan/screens/home_screen.dart';
import 'dart:math' as math;

import 'package:rayhan/services/settings.dart';

AppBar getAppBar({String title, BuildContext context}) {
  return AppBar(
    backgroundColor: Provider.of<Settings>(context).isGreenTheme
        ? kGreenPrimaryColor
        : kBluePrimaryColor,
    centerTitle: true,
    toolbarHeight: 56.0 * sizeRatio,
    leadingWidth: 56.0 * sizeRatio,
    leading: ModalRoute.of(context).settings.name != HomeScreen.id
        ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25.0 * sizeRatio,
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Icon(
            FontAwesomeIcons.pagelines,
            color: Provider.of<Settings>(context).isGreenTheme
                ? kGreenLightColor
                : kBlueLightColor,
            size: 25.0 * sizeRatio,
          ),
        ),
      ],
    ),
  );
}
