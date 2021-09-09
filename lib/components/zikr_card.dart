import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:rayhan/services/helper.dart';
import 'package:rayhan/services/settings.dart';

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
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      //color: kPrimaryColor,
                      color: Provider.of<Settings>(context).isNightTheme
                          ? Colors.white
                          : Provider.of<Settings>(context).isGreenTheme
                              ? kGreenPrimaryColor
                              : kBluePrimaryColor, //hereeee
                      fontSize:
                          Provider.of<Settings>(context).isFontMed ? 22 : 26,
                      //fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              //color: Color.fromRGBO(245, 245, 245, 1),
              color: Provider.of<Settings>(context).isNightTheme
                  ? kNightBackgroundColor
                  : kLightBackgroundColor, //hereeee
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: !Provider.of<Settings>(context).isGreenTheme
                      ? kBlueLightPrimaryColor
                      : kGreenLightPrimaryColor, //hereeee
                  offset: Offset(0.0, 1.0),
                  blurRadius: 3.0,
                ),
              ],
            ),
          ),
          widget.isCounted
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: Provider.of<Settings>(context).isNightTheme
                            ? kNightBackgroundColor
                            : Color.fromRGBO(245, 245, 245, 1), //hereeee
                        borderRadius: BorderRadius.circular(45.0),
                        boxShadow: [
                          BoxShadow(
                            color: !Provider.of<Settings>(context).isGreenTheme
                                ? kBlueLightPrimaryColor
                                : kGreenLightPrimaryColor,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          getArabicNumber(widget.number),
                          style: TextStyle(
                            fontSize: 30.0,
                            //color: kPrimaryColor, //hereeee
                            color: Provider.of<Settings>(context).isNightTheme
                                ? Colors.white
                                : Provider.of<Settings>(context).isGreenTheme
                                    ? kGreenPrimaryColor
                                    : kBluePrimaryColor,
                          ),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          widget.title.length > 0
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        color: Provider.of<Settings>(context, listen: false)
                                .isNightTheme
                            ? kNightBackgroundColor
                            : kLightBackgroundColor,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: Provider.of<Settings>(context).isFontMed
                                ? 25
                                : 28,
                            color: Provider.of<Settings>(context).isNightTheme
                                ? Colors.white
                                : Provider.of<Settings>(context).isGreenTheme
                                    ? kGreenPrimaryColor
                                    : kBluePrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Icon(
                  FontAwesomeIcons.pagelines,
                  color: !Provider.of<Settings>(context).isGreenTheme
                      ? kBlueLightPrimaryColor
                      : kGreenLightPrimaryColor, //hereeee
                  size: 60.0,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 7.0),
                  child: Icon(
                    FontAwesomeIcons.pagelines,
                    color: !Provider.of<Settings>(context).isGreenTheme
                        ? kBlueLightPrimaryColor
                        : kGreenLightPrimaryColor,
                    size: 60.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
