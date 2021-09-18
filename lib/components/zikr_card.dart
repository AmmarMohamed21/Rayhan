import 'package:flutter/material.dart';
import 'package:rayhan/components/zikr_card_container.dart';
import 'package:rayhan/components/zikr_card_counter.dart';
import 'package:rayhan/components/zikr_card_icon.dart';
import 'package:rayhan/components/zikr_card_title.dart';

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
    return GestureDetector(
      onTap: () {
        if (widget.number > 0) {
          setState(() {
            widget.number--;
          });
        } else {}
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
