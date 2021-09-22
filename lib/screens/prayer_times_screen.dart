import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/app_drawer.dart';
import 'package:rayhan/components/main_app_bar.dart';
import 'package:rayhan/components/icon_label_tile.dart';
import 'package:rayhan/services/prayer_times.dart';
import 'package:rayhan/services/settings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utilities/constants.dart';

class PrayerTimesScreen extends StatelessWidget {
  static final String id = 'prayer_times_screen';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PrayerTimes.getData(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.done) {
            return Scaffold(
              drawer: AppDrawer(),
              backgroundColor: Provider.of<Settings>(context).isNightTheme
                  ? kNightBackgroundColor
                  : kLightBackgroundColor,
              appBar: getAppBar(
                title: 'مواقيت الصلاة',
                context: context,
              ),
              body: snap.hasData
                  ? Padding(
                      padding: EdgeInsets.only(top: 10.0 * sizeRatio),
                      child: ListView(
                        children: [
                          IconLabelTile(
                            label: 'الفجر',
                            icon: CupertinoIcons.sun_dust_fill,
                            iconColor: Colors.deepOrangeAccent,
                            endWidget: Text(
                              snap.data['Fajr'],
                              style: TextStyle(
                                color:
                                    Provider.of<Settings>(context).isNightTheme
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 25.0 * sizeRatio,
                              ),
                            ),
                          ),
                          IconLabelTile(
                            label: 'الشروق',
                            icon: Icons.wb_sunny_rounded,
                            iconColor: Colors.yellow,
                            endWidget: Text(
                              snap.data['Sunrise'],
                              style: TextStyle(
                                color:
                                    Provider.of<Settings>(context).isNightTheme
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 25.0 * sizeRatio,
                              ),
                            ),
                          ),
                          IconLabelTile(
                            label: 'الظهر',
                            icon: FontAwesomeIcons.solidSun,
                            iconColor: Colors.amber,
                            endWidget: Text(
                              snap.data['Dhuhr'],
                              style: TextStyle(
                                color:
                                    Provider.of<Settings>(context).isNightTheme
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 25.0 * sizeRatio,
                              ),
                            ),
                          ),
                          IconLabelTile(
                            label: 'العصر',
                            icon: CupertinoIcons.cloud_sun_fill,
                            iconColor: Colors.orangeAccent,
                            endWidget: Text(
                              snap.data['Asr'],
                              style: TextStyle(
                                color:
                                    Provider.of<Settings>(context).isNightTheme
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 25.0 * sizeRatio,
                              ),
                            ),
                          ),
                          IconLabelTile(
                            label: 'المغرب',
                            icon: CupertinoIcons.sun_haze_fill,
                            iconColor: Colors.orange,
                            endWidget: Text(
                              snap.data['Maghrib'],
                              style: TextStyle(
                                color:
                                    Provider.of<Settings>(context).isNightTheme
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 25.0 * sizeRatio,
                              ),
                            ),
                          ),
                          IconLabelTile(
                            label: 'العشاء',
                            icon: CupertinoIcons.moon_fill,
                            iconColor:
                                Provider.of<Settings>(context).isNightTheme
                                    ? Colors.white
                                    : Color(0xFF1d3557),
                            endWidget: Text(
                              snap.data['Isha'],
                              style: TextStyle(
                                color:
                                    Provider.of<Settings>(context).isNightTheme
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 25.0 * sizeRatio,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.frown,
                          size: 50.0 * sizeRatio,
                          color: Provider.of<Settings>(context).isNightTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                        SizedBox(
                          height: 20 * sizeRatio,
                        ),
                        Text(
                          'تأكد من الاتصال بشبكة الإنترنت وتفعيل خاصية تحديد الموقع',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<Settings>(context).isNightTheme
                                ? Colors.white
                                : Colors.black,
                            fontSize: 30 * sizeRatio,
                          ),
                        ),
                      ],
                    ),
            );
          } else {
            return Scaffold(
              drawer: AppDrawer(),
              backgroundColor: Provider.of<Settings>(context).isNightTheme
                  ? kNightBackgroundColor
                  : kLightBackgroundColor,
              appBar: getAppBar(
                title: 'مواقيت الصلاة',
                context: context,
              ),
              body: Center(
                child: SpinKitChasingDots(
                  color: Provider.of<Settings>(context).isGreenTheme
                      ? kGreenPrimaryColor
                      : kBluePrimaryColor,
                  size: 60 * sizeRatio,
                ),
              ),
            );
          }
        });
  }
}
