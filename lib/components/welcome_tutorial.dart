import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/tutorial_first_page.dart';
import 'package:rayhan/components/tutorial_second_page.dart';
import 'package:rayhan/components/tutorial_third_page.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class WelcomeTutorial extends StatefulWidget {
  @override
  _WelcomeTutorialState createState() => _WelcomeTutorialState();
}

class _WelcomeTutorialState extends State<WelcomeTutorial> {
  int index = 0;

  List<Widget> contentWidgets = [
    TutorialFirstPage(),
    TutorialSecondPage(),
    TutorialThirdPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(100, 100, 100, 0.5),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom) *
                  0.5,
            ),
            width: double.infinity,
            padding: EdgeInsets.all(20.0 * sizeRatio),
            decoration: BoxDecoration(
              color: Provider.of<Settings>(context).isNightTheme
                  ? kNightBackgroundColor
                  : kLightBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0 * sizeRatio),
                topRight: Radius.circular(20.0 * sizeRatio),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'أهلًا بكم في',
                          style: TextStyle(
                            fontSize: 27.0 * sizeRatio,
                            color: Provider.of<Settings>(context).isNightTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0 * sizeRatio,
                        ),
                        Image.asset(
                          Provider.of<Settings>(context).isNightTheme
                              ? 'assets/icon/logodark.png'
                              : 'assets/icon/logo.png',
                          height: 55.0 * sizeRatio,
                          width: 55.0 * sizeRatio,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 130.0 * sizeRatio,
                      ),
                      child: Divider(
                        color: kGreenPrimaryColor,
                        thickness: 2.5 * sizeRatio,
                      ),
                    ),
                  ],
                ),

                contentWidgets[index],
                //Spacer(),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        kGreenLightColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    index == contentWidgets.length - 1 ? 'حسنًا' : 'التالي',
                    style: TextStyle(
                      fontSize: 30.0 * sizeRatio,
                      color: kGreenLightPrimaryColor,
                    ),
                  ),
                  onPressed: () {
                    if (index == contentWidgets.length - 1) {
                      Provider.of<Settings>(context, listen: false)
                          .setFirstTime();
                      return;
                    }
                    setState(() {
                      index++;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
