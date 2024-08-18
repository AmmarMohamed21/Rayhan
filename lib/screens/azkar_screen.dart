import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/azkar_components/zikr_card.dart';
import 'package:rayhan/components/shared_components/app_drawer.dart';
import 'package:rayhan/components/shared_components/main_app_bar.dart';
import 'package:rayhan/data/azkar_list.dart';
import 'package:rayhan/models/zikr.dart';

import '../providers/theme_provider.dart';

class AzkarScreen extends StatelessWidget {
  static const String id = 'azkar_screen';
  final String title;
  const AzkarScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: getAppBar(
        title: title,
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0 *
            Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        child: getAzkar(context),
      ),
    );
  }

  Scrollbar getAzkar(BuildContext context) {
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
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.right,
      thickness:
          3.0 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
          child: Column(
            children: zikrCards,
          ),
        ),
      ),
    );
  }
}
