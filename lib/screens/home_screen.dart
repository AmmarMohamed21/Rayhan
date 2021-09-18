import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/welcome_tutorial.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/components/leaf_button.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:flutter/services.dart';

import 'loading_screen.dart';

class HomeScreen extends StatelessWidget {
  static final id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      future: Provider.of<Settings>(context, listen: false)
          .initializeSettings(context),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Scaffold(
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
                          : kBlueLightPrimaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LeafButton(label: 'أذكار المساء', isInversed: true),
                          LeafButton(label: 'أذكار الصلاة', isInversed: true),
                          LeafButton(label: 'الإعدادات', isInversed: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Provider.of<Settings>(context).firstTime
                  ? Scaffold(
                      backgroundColor: Colors.white.withAlpha(0),
                      body: WelcomeTutorial(),
                    )
                  : SizedBox.shrink(),
            ],
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
