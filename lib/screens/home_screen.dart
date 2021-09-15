import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/custom_icons.dart';
import 'package:rayhan/components/drawer_list_tile.dart';
import 'package:rayhan/constants.dart';
import 'package:rayhan/components/leaf_button.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';

import 'azkar_screen.dart';

class HomeScreen extends StatelessWidget {
  static final id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Settings>(context, listen: false)
            .initializeSettings(context),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.done) {
            return Scaffold(
              drawer: AppDrawer(),
              backgroundColor:
                  Provider.of<Settings>(context, listen: false).isNightTheme
                      ? kNightBackgroundColor
                      : kLightBackgroundColor,
              appBar: getAppBar(title: 'روحٌ وريحان', context: context),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LeafButton(label: 'أذكار الصباح', isInversed: false),
                        LeafButton(label: 'أذكار النوم', isInversed: false),
                        LeafButton(label: 'أذكار متفرقة', isInversed: false),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 8.0,
                    width: 8.0,
                    color: Provider.of<Settings>(context, listen: false)
                            .isGreenTheme
                        ? kGreenLightPrimaryColor
                        : kBlueLightPrimaryColor, //hereeee
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LeafButton(label: 'أذكار المساء', isInversed: true),
                        LeafButton(label: 'أذكار الصلاة', isInversed: true),
                        LeafButton(label: 'الإعدادات', isInversed: true),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor:
                  SchedulerBinding.instance.window.platformBrightness ==
                          Brightness.dark
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
        });
  }
}
