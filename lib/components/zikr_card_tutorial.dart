import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:rayhan/utilities/helper.dart';

class ZikrCardTutorial extends StatefulWidget {
  @override
  _ZikrCardTutorialState createState() => _ZikrCardTutorialState();
}

class _ZikrCardTutorialState extends State<ZikrCardTutorial> {
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
                    color: Provider.of<Settings>(context).isNightTheme
                        ? Colors.white
                        : kGreenPrimaryColor,
                    fontSize: 22 * sizeRatio,
                  ),
                ),
              ],
            ),
          ),
          margin: EdgeInsets.all(20.0 * sizeRatio),
          decoration: BoxDecoration(
            color: Provider.of<Settings>(context).isNightTheme
                ? kNightBackgroundColor
                : kLightBackgroundColor,
            borderRadius: BorderRadius.circular(10.0 * sizeRatio),
            boxShadow: [
              BoxShadow(
                color: kGreenLightPrimaryColor,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0 * sizeRatio,
              ),
            ],
          ),
        ),
        showCircle
            ? Positioned.fill(
                child: Align(
                  alignment: Alignment(0.48, 0.39),
                  child: CircleAvatar(
                    backgroundColor: Provider.of<Settings>(context).isNightTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black26.withOpacity(0.1),
                    radius: 30.0 * sizeRatio,
                  ),
                ),
              )
            : SizedBox.shrink(),
        Positioned.fill(
          child: Align(
            alignment: Alignment(0.5, 1),
            child: Icon(
              Icons.touch_app,
              size: 65.0 * sizeRatio,
              color: Provider.of<Settings>(context).isNightTheme
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
                color: Provider.of<Settings>(context).isNightTheme
                    ? kNightBackgroundColor
                    : Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.circular(45.0 * sizeRatio),
                boxShadow: [
                  BoxShadow(
                    color: kGreenLightPrimaryColor,
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
                    color: Provider.of<Settings>(context).isNightTheme
                        ? Colors.white
                        : kGreenPrimaryColor,
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
                color: kGreenLightPrimaryColor,
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
                  color: kGreenLightPrimaryColor,
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
