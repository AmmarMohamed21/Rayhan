import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/azkar_components/zikr_card.dart';
import 'package:rayhan/components/shared_components/app_drawer.dart';
import 'package:rayhan/components/shared_components/main_app_bar.dart';
import 'package:rayhan/models/zikr.dart';
import 'package:rayhan/providers/azkar_list_provider.dart';
import 'package:rayhan/utilities/constants.dart';

import '../components/azkar_components/falling_leave.dart';
import '../providers/azkar_provider.dart';
import '../providers/theme_provider.dart';

class AzkarScreen extends StatelessWidget {
  static const String id = 'azkar_screen';
  final String title;
  final random = Random();

  AzkarScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          AzkarListProvider(currentAzkar: getAzkarList(context, title)),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.topCenter,
          children: getStackList(context),
        );
      },
    );
  }

  List<Zikr> getAzkarList(BuildContext context, String title) {
    if (title == 'أذكار الصباح')
      return Provider.of<AzkarProvider>(context, listen: false)
          .azkarList!
          .azkarSabah;
    if (title == 'أذكار المساء')
      return Provider.of<AzkarProvider>(context, listen: false)
          .azkarList!
          .azkarMasaa;
    if (title == 'أذكار الصلاة')
      return Provider.of<AzkarProvider>(context, listen: false)
          .azkarList!
          .azkarSalah;
    if (title == 'أذكار النوم')
      return Provider.of<AzkarProvider>(context, listen: false)
          .azkarList!
          .azkarNawm;
    if (title == 'أذكار متفرقة')
      return Provider.of<AzkarProvider>(context, listen: false)
          .azkarList!
          .azkarMotafreqa;
    return [];
  }

  List<Widget> getStackList(BuildContext context) {
    List<Color> possibleColors = [
      kGreenLightColor,
      kGreenPrimaryColor,
      kGreenDarkColor
    ];
    List<Widget> widgets = [
      Scaffold(
        drawer: const AppDrawer(),
        appBar: getAppBar(
          title: title,
          context: context,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            thickness: 3.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(2.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio),
                child: Column(
                  children:
                      Provider.of<AzkarListProvider>(context, listen: false)
                          .currentAzkar
                          .map((Zikr zikr) {
                    return ZikrCard(zikr: zikr);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      )
    ];
    for (int i = 0; i < 50; i++) {
      widgets.add(Provider.of<AzkarListProvider>(context).isCounterDone
          ? FallingLeave(
              color: possibleColors[random.nextInt(3)],
              fallDuration: random.nextInt(9001),
              isReverted: random.nextBool(),
              leftPositionInitial:
                  random.nextDouble() * MediaQuery.of(context).size.width)
          : SizedBox.shrink());
    }
    return widgets;
  }
}
