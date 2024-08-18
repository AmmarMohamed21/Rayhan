import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/home_components/tutorial_widget_prayer.dart';

import '../../providers/theme_provider.dart';
import '../../utilities/helper.dart';

class HomeWidgetTutorial extends StatelessWidget {
  const HomeWidgetTutorial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${addZeroToSingleDigit(getArabicNumber(DateTime.now().hour))}:${addZeroToSingleDigit(getArabicNumber(DateTime.now().minute))}",
            style: TextStyle(
              fontSize: 25.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.35,
            width: MediaQuery.of(context).size.width *
                0.55, // Placeholder for your widget
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color: Color(0xFF333333),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'مواقيت الصلاة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18 *
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .sizeRatio),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TutorialWidgetPrayer(
                        icon: CupertinoIcons.sun_dust_fill,
                        name: 'الفجر',
                        color: Colors.deepOrangeAccent,
                      ),
                      TutorialWidgetPrayer(
                        icon: Icons.wb_sunny_rounded,
                        name: 'الشروق',
                        color: Colors.yellow,
                      ),
                      TutorialWidgetPrayer(
                        icon: FontAwesomeIcons.solidSun,
                        name: 'الظهر',
                        color: Colors.amber,
                      ),
                      TutorialWidgetPrayer(
                        icon: CupertinoIcons.cloud_sun_fill,
                        name: 'العصر',
                        color: Colors.orangeAccent,
                      ),
                      TutorialWidgetPrayer(
                        icon: CupertinoIcons.sun_haze_fill,
                        name: 'المغرب',
                        color: Colors.orange,
                      ),
                      TutorialWidgetPrayer(
                        icon: CupertinoIcons.moon_fill,
                        name: 'العشاء',
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF1d3557),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.purple,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
              Icon(
                Icons.photo,
                color: Colors.blue,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
              Icon(
                Icons.message,
                color: Colors.orange,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
              Icon(
                Icons.phone,
                color: Colors.green,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
