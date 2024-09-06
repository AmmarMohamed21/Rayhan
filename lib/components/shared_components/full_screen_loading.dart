import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/utilities/constants.dart';

import '../../providers/theme_provider.dart';

class DialogueManager {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black12,
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: SpinKitPouringHourGlassRefined(
                  color: kGreenPrimaryColor,
                  size: 60 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio,
                ),
              ),
            ),
          );
        });
  }
}
