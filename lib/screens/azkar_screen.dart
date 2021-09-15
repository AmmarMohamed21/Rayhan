import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/zikr_card.dart';
import 'package:rayhan/components/custom_icons.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/constants.dart';
import 'dart:math' as math;
import 'package:rayhan/services/azkar_list.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/services/zikr.dart';
import 'dart:math' as math;

class AzkarScreen extends StatelessWidget {
  static final String id = 'azkar_screen';
  final String title;
  AzkarScreen({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Provider.of<Settings>(context).isNightTheme
          ? kNightBackgroundColor
          : kLightBackgroundColor,
      appBar: getAppBar(
        title: title,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
        thickness: 3.0,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: ListView(
            padding: const EdgeInsets.all(2.0),
            children: zikrCards,
          ),
        ),
      ),
    );
  }
}
