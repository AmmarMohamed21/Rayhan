import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/scaled_switch.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

class SwitchNotificationTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSabah;
  final bool isActive;

  const SwitchNotificationTile(
      {super.key,
      required this.label,
      required this.icon,
      required this.iconColor,
      required this.isSabah,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setNotification(context);
      },
      child: Container(
        constraints: BoxConstraints(minHeight: 45.0 * sizeRatio),
        //height: 45.0 * heightRatio * widthRatio,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 45.0 * sizeRatio,
            ),
            SizedBox(
              width: 17.0 * sizeRatio,
            ),
            Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 25.0 * sizeRatio,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                isActive
                    ? Text(
                        getSubtitle(isSabah, context),
                        style: TextStyle(
                          fontSize: 20.0 * sizeRatio,
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
                  setNotification(context);
                } else {
                  if (isSabah) {
                    Provider.of<SettingsProvider>(context, listen: false)
                        .cancelNotification(
                            NotificationIDs.morningNotificationID.index);
                  } else {
                    Provider.of<SettingsProvider>(context, listen: false)
                        .cancelNotification(
                            NotificationIDs.dawnNotificationID.index);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void setNotification(BuildContext context) async {
    late TimeOfDay initialTime;
    if (isSabah) {
      initialTime = const TimeOfDay(hour: 6, minute: 0);
    } else {
      initialTime = const TimeOfDay(hour: 17, minute: 0);
    }
    String title = isSabah ? 'الصباح' : 'المساء';
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
          isSabah
              ? NotificationIDs.morningNotificationID.index
              : NotificationIDs.dawnNotificationID.index);
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
          isSabah
              ? NotificationIDs.morningNotificationID.index
              : NotificationIDs.dawnNotificationID.index);
      return;
    }
    if (isSabah) {
      Provider.of<SettingsProvider>(context, listen: false)
          .activateMorningNotificationsTime(timeOfDay);
    } else {
      Provider.of<SettingsProvider>(context, listen: false)
          .activateDawnNotifications(timeOfDay);
    }
  }
}
