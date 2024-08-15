import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/components/zikr_card.dart';
import 'package:rayhan/data/azkar_list.dart';
import 'package:rayhan/models/zikr.dart';
import 'package:rayhan/utilities/constants.dart';

class AzkarScreen extends StatelessWidget {
  static const String id = 'azkar_screen';
  final String title;
  const AzkarScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      // backgroundColor: Theme.of(context).brightness == Brightness.dark
      //     ? kDarkBackgroundColor
      //     : kLightBackgroundColor,
      appBar: getAppBar(
        title: title,
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0 * sizeRatio),
        child: getAzkar(),
      ),
    );
  }

  Transform getAzkar() {
    List<Zikr> azkarList = AzkarList.getAzkarList(title);
    List<ZikrCard> zikrCards = [];
    for (Zikr zikr in azkarList) {
      zikrCards.add(ZikrCard(
        text: zikr.text,
        number: zikr.count,
        title: zikr.title,
        isCounted: zikr.count == 0 ? false : true,
      ));
    }
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Scrollbar(
        thickness: 3.0 * sizeRatio,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: ListView(
            padding: EdgeInsets.all(2.0 * sizeRatio),
            children: zikrCards,
          ),
        ),
      ),
    );
  }
}
