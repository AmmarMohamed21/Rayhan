import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rayhan/screens/azkar_screen.dart';
import 'package:rayhan/services/notifications_service.dart';
import 'package:rayhan/utilities/constants.dart';

import '../screens/home_screen.dart';
import '../services/local_storage.dart';

class SettingsProvider extends ChangeNotifier {
  bool? isSabahActive;
  bool? isMasaaActive;
  TimeOfDay? sabahTime;
  TimeOfDay? masaaTime;

  bool? isFontMed;

  bool? firstTime;

  Future<void> initializeSettings(BuildContext context) async {
    //variables initializations
    await Future.delayed(Duration(seconds: 2));

    firstTime = await LocalStorage.isFirstTime();

    isFontMed = await LocalStorage.isFontMed();

    isSabahActive = await LocalStorage.isMorningNotificationsSet();
    isMasaaActive = await LocalStorage.isDawnNotificationsSet();
    sabahTime = await LocalStorage.getMorningNotificationTime();
    masaaTime = await LocalStorage.getDawnNotificationTime();

    if (!(firstTime)!) {
      if (!(await LocalStorage.isFridayNotificationsSet())) {
        await NotificationsService.setWeeklyFridayNotification();
      }
    }

    final FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await notificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((NotificationAppLaunchDetails? notificationAppLaunchDetails) {
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        if (notificationAppLaunchDetails?.notificationResponse?.payload !=
            null) {
          String payload =
              (notificationAppLaunchDetails?.notificationResponse?.payload)!;
          if (payload != "أذكار الصباح" && payload != "أذكار المساء") {
            return;
          }
          Navigator.popAndPushNamed(context, HomeScreen.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AzkarScreen(
                title: (notificationAppLaunchDetails
                    ?.notificationResponse?.payload)!,
              ),
            ),
          );
        }
      } else {
        Navigator.popAndPushNamed(context, HomeScreen.id);
      }
    });
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    NotificationsService.cancelNotification(
        NotificationIDs.dawnNotificationID.index);
    if (id == NotificationIDs.morningNotificationID.index) {
      LocalStorage.setMorningNotifications(false);
      isSabahActive = false;
    } else {
      LocalStorage.setDawnNotifications(false);
      isMasaaActive = false;
    }
    notifyListeners();
  }

  Future<void> activateDawnNotifications(TimeOfDay timeOfDay) async {
    LocalStorage.setDawnNotificationTime(timeOfDay);
    LocalStorage.setDawnNotifications(true);
    masaaTime = timeOfDay;
    isMasaaActive = true;
    NotificationsService.setAzkarNotification(
        NotificationIDs.dawnNotificationID.index);
    notifyListeners();
  }

  Future<void> activateMorningNotificationsTime(TimeOfDay timeOfDay) async {
    await LocalStorage.setMorningNotificationTime(timeOfDay);
    await LocalStorage.setMorningNotifications(true);
    sabahTime = timeOfDay;
    isSabahActive = true;
    NotificationsService.setAzkarNotification(
        NotificationIDs.morningNotificationID.index);
    notifyListeners();
  }

  Future<void> setIsFontMed(bool value) async {
    isFontMed = value;
    LocalStorage.setFontMed(value);
    notifyListeners();
  }

  Future<void> setFirstTime() async {
    firstTime = false;
    LocalStorage.setFirstTime();
    if (!(await LocalStorage.isFridayNotificationsSet())) {
      NotificationsService.setWeeklyFridayNotification();
    }
    notifyListeners();
  }
}
