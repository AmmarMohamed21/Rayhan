import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayhan/screens/home_screen.dart';
import 'package:rayhan/utilities/constants.dart';

AppBar getAppBar({required String title, required BuildContext context}) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColorDark,
    centerTitle: true,
    toolbarHeight: 56.0 * sizeRatio,
    leadingWidth: 56.0 * sizeRatio,
    iconTheme: IconThemeData(color: Colors.white),
    leading: ModalRoute.of(context)?.settings.name != HomeScreen.id
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
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
            color: Colors.white,
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Icon(
            FontAwesomeIcons.pagelines,
            color: Theme.of(context).primaryColorLight,
            size: 25.0 * sizeRatio,
          ),
        ),
      ],
    ),
  );
}
