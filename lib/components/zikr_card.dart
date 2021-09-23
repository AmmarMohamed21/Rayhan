import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/zikr_card_container.dart';
import 'package:rayhan/components/zikr_card_counter.dart';
import 'package:rayhan/components/zikr_card_icon.dart';
import 'package:rayhan/components/zikr_card_title.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:flutter/services.dart';

class ZikrCard extends StatefulWidget {
  final String text;
  final String title;
  int number;
  final bool isCounted;

  ZikrCard({this.text, this.title, this.number, this.isCounted});

  @override
  _ZikrCardState createState() => _ZikrCardState();
}

class _ZikrCardState extends State<ZikrCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Provider.of<Settings>(context, listen: false).isNightTheme
          ? Color.fromRGBO(55, 55, 55, 0.2)
          : Color.fromRGBO(215, 215, 215, 0.2),
      splashColor: Provider.of<Settings>(context, listen: false).isNightTheme
          ? Color.fromRGBO(55, 55, 55, 0.2)
          : Color.fromRGBO(215, 215, 215, 0.2),
      borderRadius: BorderRadius.circular(20.0 * sizeRatio),
      onTap: () {
        if (widget.number > 0) {
          setState(() {
            widget.number--;
          });
        } else {}
      },
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: widget.text));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:
              Provider.of<Settings>(context, listen: false).isNightTheme
                  ? kNightBackgroundColor
                  : kLightBackgroundColor,
          content: Text(
            'تم نسخ الذكر',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Harmattans',
              fontSize: 20.0 * sizeRatio,
              color: Provider.of<Settings>(context, listen: false).isNightTheme
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          duration: Duration(seconds: 1),
        ));
      },
      child: Stack(
        children: [
          ZikrCardContainer(text: widget.text),
          widget.isCounted
              ? ZikrCardCounter(
                  number: widget.number,
                )
              : SizedBox.shrink(),
          widget.title.length > 0
              ? ZikrCardTitle(title: widget.title)
              : SizedBox.shrink(),
          ZikrCardIcon(),
          ZikrCardIcon(isReversed: true),
        ],
      ),
    );
  }
}
