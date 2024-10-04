import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/azkar_components/zikr_card_container.dart';
import 'package:rayhan/components/azkar_components/zikr_card_counter.dart';
import 'package:rayhan/components/azkar_components/zikr_card_icon.dart';
import 'package:rayhan/components/azkar_components/zikr_card_title.dart';
import 'package:rayhan/utilities/constants.dart';

import '../../models/zikr.dart';
import '../../providers/azkar_list_provider.dart';
import '../../providers/theme_provider.dart';

class ZikrCard extends StatefulWidget {
  final Zikr zikr;
  const ZikrCard({
    super.key,
    required this.zikr,
  });

  @override
  ZikrCardState createState() => ZikrCardState();
}

class ZikrCardState extends State<ZikrCard> {
  late int currentNumber;

  @override
  void initState() {
    super.initState();
    currentNumber = widget.zikr.count;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromRGBO(55, 55, 55, 0.2)
          : const Color.fromRGBO(215, 215, 215, 0.2),
      splashColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromRGBO(55, 55, 55, 0.2)
          : const Color.fromRGBO(215, 215, 215, 0.2),
      borderRadius: BorderRadius.circular(
          20.0 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
      onTap: () {
        if (currentNumber > 0) {
          Provider.of<AzkarListProvider>(context, listen: false)
              .decrementCounter();
          setState(() {
            currentNumber--;
          });
        }
      },
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: widget.zikr.text));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? kDarkBackgroundColor
              : kLightBackgroundColor,
          content: Text(
            'تم نسخ الذكر',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Harmattans',
              fontSize: 20.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          duration: const Duration(seconds: 1),
        ));
      },
      child: Stack(
        children: [
          ZikrCardContainer(text: widget.zikr.text),
          widget.zikr.count > 0
              ? ZikrCardCounter(
                  number: currentNumber,
                )
              : const SizedBox.shrink(),
          widget.zikr.title != null
              ? ZikrCardTitle(title: widget.zikr.title!)
              : const SizedBox.shrink(),
          ZikrCardIcon(),
          ZikrCardIcon(isReversed: true),
        ],
      ),
    );
  }
}
