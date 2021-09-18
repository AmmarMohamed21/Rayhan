import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rayhan/utilities/constants.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? kNightBackgroundColor
              : kLightBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SpinKitPulse(
              color: kGreenPrimaryColor,
              size: 160.0,
            ),
          ),
          Image.asset(
            SchedulerBinding.instance.window.platformBrightness ==
                    Brightness.dark
                ? 'assets/icon/logodark.png'
                : 'assets/icon/logo.png',
            width: 120,
            height: 120,
          ),
        ],
      ),
    );
  }
}
