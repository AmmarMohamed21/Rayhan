import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/leaf_button.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/components/welcome_tutorial.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          drawer: const AppDrawer(),
          appBar: getAppBar(title: 'روحٌ وريحان', context: context),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 50.0 * sizeRatio,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LeafButton(
                      label: 'أذكار الصباح',
                      isInverse: false,
                      position: 1,
                    ),
                    LeafButton(
                        label: 'أذكار النوم', isInverse: false, position: 1),
                    LeafButton(
                      label: 'أذكار متفرقة',
                      isInverse: false,
                      position: 2,
                    ),
                  ],
                ),
              ),
              // VerticalDivider(
              //   thickness: 8.0 * sizeRatio,
              //   width: 8.0 * sizeRatio,
              //   color: Theme.of(context).primaryColor,
              // ),
              Container(
                width: 8.0 * sizeRatio,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColorLight,
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColorLight,
                      offset: Offset(-1, 1),
                      blurRadius: 2 * sizeRatio,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50.0 * sizeRatio,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LeafButton(
                      label: 'أذكار المساء',
                      isInverse: true,
                      position: 0,
                    ),
                    LeafButton(
                      label: 'أذكار الصلاة',
                      isInverse: true,
                      position: 1,
                    ),
                    LeafButton(
                      label: 'الإعدادات',
                      isInverse: true,
                      position: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Provider.of<SettingsProvider>(context).firstTime ?? true
            ? Scaffold(
                backgroundColor: Colors.white.withAlpha(0),
                body: WelcomeTutorial(),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
