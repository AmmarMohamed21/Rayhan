import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/shared_components/app_drawer.dart';
import 'package:rayhan/components/shared_components/icon_label_tile.dart';
import 'package:rayhan/components/shared_components/main_app_bar.dart';

import '../providers/prayer_times_provider.dart';
import '../providers/theme_provider.dart';

class PrayerTimesScreen extends StatelessWidget {
  static const String id = 'prayer_times_screen';

  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: getAppBar(
        title: 'مواقيت الصلاة',
        context: context,
      ),
      body: FutureBuilder(
        future: Provider.of<PrayerTimesProvider>(context, listen: false)
            .loadPrayerTimes(), //PrayerTimesService.getPrayerTimes(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.done) {
            return Provider.of<PrayerTimesProvider>(context).prayerTimes != null
                ? RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    onRefresh: () async {
                      await Provider.of<PrayerTimesProvider>(context,
                              listen: false)
                          .loadPrayerTimes(isRefreshing: true);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20.0 *
                          Provider.of<ThemeProvider>(context, listen: false)
                              .sizeRatio),
                      child: ListView(
                        children: [
                          IconLabelTile(
                            label: 'الفجر',
                            icon: CupertinoIcons.sun_dust_fill,
                            iconColor: Colors.deepOrangeAccent,
                            endWidget: Text(
                              Provider.of<PrayerTimesProvider>(context)
                                  .prayerTimes!
                                  .fajr,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25.0 *
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .sizeRatio,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0 *
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .sizeRatio,
                          ),
                          IconLabelTile(
                            label: 'الشروق',
                            icon: Icons.wb_sunny_rounded,
                            iconColor: Colors.yellow,
                            endWidget: Text(
                              Provider.of<PrayerTimesProvider>(context)
                                  .prayerTimes!
                                  .sunrise,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25.0 *
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .sizeRatio,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0 *
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .sizeRatio,
                          ),
                          IconLabelTile(
                            label: 'الظهر',
                            icon: FontAwesomeIcons.solidSun,
                            iconColor: Colors.amber,
                            endWidget: Text(
                              Provider.of<PrayerTimesProvider>(context)
                                  .prayerTimes!
                                  .dhuhr,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25.0 *
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .sizeRatio,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0 *
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .sizeRatio,
                          ),
                          IconLabelTile(
                            label: 'العصر',
                            icon: CupertinoIcons.cloud_sun_fill,
                            iconColor: Colors.orangeAccent,
                            endWidget: Text(
                              Provider.of<PrayerTimesProvider>(context)
                                  .prayerTimes!
                                  .asr,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25.0 *
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .sizeRatio,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0 *
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .sizeRatio,
                          ),
                          IconLabelTile(
                            label: 'المغرب',
                            icon: CupertinoIcons.sun_haze_fill,
                            iconColor: Colors.orange,
                            endWidget: Text(
                              Provider.of<PrayerTimesProvider>(context)
                                  .prayerTimes!
                                  .maghrib,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25.0 *
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .sizeRatio,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0 *
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .sizeRatio,
                          ),
                          IconLabelTile(
                            label: 'العشاء',
                            icon: CupertinoIcons.moon_fill,
                            iconColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : const Color(0xFF1d3557),
                            endWidget: Text(
                              Provider.of<PrayerTimesProvider>(context)
                                  .prayerTimes!
                                  .isha,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 25.0 *
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .sizeRatio,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0 *
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .sizeRatio,
                          ),
                          Text(
                            "${Provider.of<PrayerTimesProvider>(context).prayerTimes!.arabicDayName}، ${Provider.of<PrayerTimesProvider>(context).prayerTimes!.arabicDate}\n${Provider.of<PrayerTimesProvider>(context).prayerTimes!.city}",
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.5),
                              fontSize: 14.0 *
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .sizeRatio,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Provider.of<PrayerTimesProvider>(context).isNoInternet
                    ? ErrorMessage(
                        icon: Icons.wifi_off,
                        message: 'تأكد من الاتصال بشبكة الإنترنت',
                      )
                    : Provider.of<PrayerTimesProvider>(context)
                            .isLocationServiceDisabled
                        ? ErrorMessage(
                            icon: Icons.location_off_outlined,
                            message: 'يرجى تفعيل خاصية تحديد الموقع',
                          )
                        : Provider.of<PrayerTimesProvider>(context)
                                    .isPermissionDenied ||
                                Provider.of<PrayerTimesProvider>(context)
                                    .isPermissionDeniedForever
                            ? ErrorMessage(
                                icon: Icons.location_off_outlined,
                                message:
                                    'يرجى السماح باستخدام خاصية تحديد الموقع',
                              )
                            : ErrorMessage(
                                icon: FontAwesomeIcons.faceFrown,
                                message:
                                    'تأكد من الاتصال بشبكة الإنترنت وتفعيل خاصية تحديد الموقع',
                              );
          } else {
            return Center(
              child: SpinKitChasingDots(
                color: Theme.of(context).primaryColorDark,
                size: 60 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
              ),
            );
          }
        },
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.icon,
    required this.message,
  });
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.faceFrown,
          size: 50.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        SizedBox(
          height:
              20 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
        ),
        Text(
          'تأكد من الاتصال بشبكة الإنترنت وتفعيل خاصية تحديد الموقع',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontSize: 30 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
        ),
      ],
    );
  }
}
