import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/settings_components/scaled_switch.dart';
import 'package:rayhan/components/shared_components/full_screen_loading.dart';
import 'package:rayhan/models/monthly_prayer_times.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

import '../../providers/prayer_times_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/local_storage.dart';

class SwitchNotificationTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isActive;
  final int notificationId;

  const SwitchNotificationTile(
      {super.key,
      required this.label,
      required this.icon,
      required this.iconColor,
      required this.notificationId,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (notificationId == fajrNotificationId) {
          if (isActive) {
            Provider.of<SettingsProvider>(context, listen: false)
                .cancelNotification(notificationId);
          } else {
            setFajrNotification(context);
          }
        } else {
          setAzkarNotification(context);
        }
      },
      child: Container(
        constraints: BoxConstraints(
            minHeight: 50.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        //height: 45.0 * heightRatio * widthRatio,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 45.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
            SizedBox(
              width: 17.0 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
            Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 25.0 *
                        Provider.of<ThemeProvider>(context, listen: false)
                            .sizeRatio,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                isActive && notificationId != fajrNotificationId
                    ? Text(
                        getSubtitle(notificationId, context),
                        style: TextStyle(
                          fontSize: 20.0 *
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .sizeRatio,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const Spacer(),
            ScaledSwitch(
              isActive: isActive,
              onChanged: (bool value) {
                if (value) {
                  notificationId == fajrNotificationId
                      ? setFajrNotification(context)
                      : setAzkarNotification(context);
                } else {
                  Provider.of<SettingsProvider>(context, listen: false)
                      .cancelNotification(notificationId);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void setFajrNotification(BuildContext context) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    if (result != true) {
      Provider.of<SettingsProvider>(context, listen: false)
          .cancelNotification(notificationId);
      return;
    }
    MonthlyPrayerTimes? cachedPrayerTimes =
        await LocalStorage.getCachedPrayerTimes();
    if (cachedPrayerTimes == null) {
      DialogueManager.showLoadingDialog(context);
      await Provider.of<PrayerTimesProvider>(context, listen: false)
          .loadPrayerTimes(context);
      Navigator.of(context).pop();
      if (Provider.of<PrayerTimesProvider>(context, listen: false)
              .prayerTimes ==
          null) {
        Provider.of<SettingsProvider>(context, listen: false)
            .cancelNotification(notificationId);
        return;
      }
    }

    Provider.of<SettingsProvider>(context, listen: false)
        .activateFajrNotification();
  }

  void setAzkarNotification(BuildContext context) async {
    late TimeOfDay initialTime;
    if (notificationId == morningNotificationId) {
      initialTime = const TimeOfDay(hour: 6, minute: 0);
    } else {
      initialTime = const TimeOfDay(hour: 17, minute: 0);
    }
    String title =
        notificationId == morningNotificationId ? 'الصباح' : 'المساء';
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        confirmText: 'تأكيد',
        cancelText: 'إلغاء',
        helpText: "اختر وقت إشعار $title",
        initialTime: initialTime,
        builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: false,
              ),
              child: child!,
            ));
    if (timeOfDay == null) {
      Provider.of<SettingsProvider>(context, listen: false).cancelNotification(
          notificationId == morningNotificationId
              ? morningNotificationId
              : dawnNotificationId);
      return;
    }
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    if (result != true) {
      Provider.of<SettingsProvider>(context, listen: false).cancelNotification(
          notificationId == morningNotificationId
              ? morningNotificationId
              : dawnNotificationId);
      return;
    }
    if (notificationId == morningNotificationId) {
      Provider.of<SettingsProvider>(context, listen: false)
          .activateMorningNotificationsTime(timeOfDay);
    } else {
      Provider.of<SettingsProvider>(context, listen: false)
          .activateDawnNotifications(timeOfDay);
    }
  }
}
