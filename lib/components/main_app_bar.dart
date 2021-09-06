import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

import 'package:rayhan/services/settings.dart';

AppBar getAppBar({String title, BuildContext context}) {
  return AppBar(
    backgroundColor: Provider.of<Settings>(context).isGreenTheme
        ? kGreenPrimaryColor
        : kBluePrimaryColor,
    // leading: Hero(
    //   tag: 'logo',
    //   child: Padding(
    //     padding: const EdgeInsets.all(2.0),
    //     child: Container(
    //       //color: Colors.white,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(5.0),
    //       ),
    //       child: Image.asset(
    //         'assets/icon/logo.png',
    //         // width: 120,
    //         // height: 120,
    //       ),
    //     ),
    //   ),
    // ),
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25.0,
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
          ),
        ),
      ],
    ),
  );
}
