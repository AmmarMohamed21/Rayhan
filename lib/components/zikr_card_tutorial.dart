import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

class ZikrCardTutorial extends StatefulWidget {
  const ZikrCardTutorial({super.key});

  @override
  ZikrCardTutorialState createState() => ZikrCardTutorialState();
}

class ZikrCardTutorialState extends State<ZikrCardTutorial> {
  int number = 3;
  bool showCircle = false;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(20.0 * sizeRatio),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.0 * sizeRatio),
            boxShadow: [
              BoxShadow(
                color: kGreenPrimaryColor,
                offset: const Offset(0.0, 1.0),
                blurRadius: 3.0 * sizeRatio,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0 * sizeRatio),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'سُبحَان اللَّه.',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : kGreenDarkColor,
                    fontSize: 22 * sizeRatio,
                  ),
                ),
              ],
            ),
          ),
        ),
        showCircle
            ? Positioned.fill(
                child: Align(
                  alignment: const Alignment(0.48, 0.39),
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black26.withOpacity(0.1),
                    radius: 30.0 * sizeRatio,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Positioned.fill(
          child: Align(
            alignment: const Alignment(0.5, 1),
            child: Icon(
              Icons.touch_app,
              size: 65.0 * sizeRatio,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 45.0 * sizeRatio,
              height: 45.0 * sizeRatio,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? kDarkBackgroundColor
                    : const Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.circular(45.0 * sizeRatio),
                boxShadow: [
                  BoxShadow(
                    color: kGreenPrimaryColor,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 3.0 * sizeRatio,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  getArabicNumber(number),
                  style: TextStyle(
                    fontSize: 30.0 * sizeRatio,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : kGreenDarkColor,
                  ),
                  //textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Icon(
                FontAwesomeIcons.pagelines,
                color: kGreenPrimaryColor,
                size: 60.0 * sizeRatio,
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
                  color: kGreenPrimaryColor,
                  size: 60.0 * sizeRatio,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void startAnimation() async {
    while (true) {
      if (!mounted) return;
      setState(() {
        number = 3;
      });

      for (int i = 0; i < 3; i++) {
        await Future.delayed(Duration(seconds: 1));
        if (!mounted) return;
        setState(() {
          showCircle = true;
          number--;
        });
        await Future.delayed(Duration(milliseconds: 200));
        if (!mounted) return;
        setState(() {
          showCircle = false;
        });
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
