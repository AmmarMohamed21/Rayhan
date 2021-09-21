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
              minHeight: 396.0 * heightRatio,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
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
                            fontSize: 27.0 * heightRatio,
                          ),
                        ),
                        SizedBox(
                          width: 10.0 * heightRatio,
                        ),
                        Image.asset(
                          'assets/icon/logo.png',
                          height: 55.0 * heightRatio,
                          width: 55.0 * heightRatio,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 130.0 * widthRatio,
                      ),
                      child: Divider(
                        color: kGreenPrimaryColor,
                        thickness: 2.5,
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
                      fontSize: 30.0 * heightRatio,
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
