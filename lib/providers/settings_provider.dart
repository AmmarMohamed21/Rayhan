import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rayhan/screens/azkar_screen.dart';
import 'package:rayhan/screens/prayer_times_screen.dart';
import 'package:rayhan/services/notifications_service.dart';
import 'package:rayhan/utilities/constants.dart';

import '../screens/home_screen.dart';
import '../services/local_storage.dart';

class SettingsProvider extends ChangeNotifier {
  bool? isSabahActive;
  bool? isMasaaActive;
  bool? isFajrActive;
  TimeOfDay? sabahTime;
  TimeOfDay? masaaTime;

  bool? isFontMed;

  bool? firstTime;

  Future<void> initializeSettings(BuildContext context) async {
    //variables initializations
    await Future.delayed(Duration(seconds: 2));

    firstTime = await LocalStorage.isFirstTime();

    isFontMed = await LocalStorage.isFontMed();

    isFajrActive = await LocalStorage.isFajrNotificationSet();

    isSabahActive = await LocalStorage.isMorningNotificationsSet();
    isMasaaActive = await LocalStorage.isDawnNotificationsSet();
    sabahTime = await LocalStorage.getMorningNotificationTime();
    masaaTime = await LocalStorage.getDawnNotificationTime();

    if (!(firstTime)!) {
      if (!(await LocalStorage.isFridayNotificationsSet())) {
        await NotificationsService.setWeeklyFridayNotification();
      }
    }

    Uri? uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (uri != null) {
      log(uri.toString());
      Navigator.popAndPushNamed(context, HomeScreen.id);
      if (uri.toString().contains("refresh")) {
        Navigator.pushNamed(context, PrayerTimesScreen.id);
      }
    } else {
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
    }

    HomeWidget.widgetClicked.listen((Uri? uri) {
      if (uri != null && uri.toString().contains("refresh")) {
        final navigator = navigatorKey.currentState;
        if (navigator != null) {
          while (navigator.canPop()) {
            navigator.pop();
          }
          navigator.popAndPushNamed(HomeScreen.id);
          navigator.pushNamed(PrayerTimesScreen.id);
        }
      }
    });

    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    NotificationsService.cancelNotification(id);
    if (id == morningNotificationId) {
      LocalStorage.setMorningNotifications(false);
      isSabahActive = false;
    } else if (id == dawnNotificationId) {
      LocalStorage.setDawnNotifications(false);
      isMasaaActive = false;
    } else if (id == fajrNotificationId) {
      LocalStorage.setFajrNotification(false);
      isFajrActive = false;
    }
    notifyListeners();
  }

  Future<void> activateFajrNotification() async {
    LocalStorage.setFajrNotification(true);
    isFajrActive = true;
    NotificationsService.updateFajrNotification();
    notifyListeners();
  }

  Future<void> activateDawnNotifications(TimeOfDay timeOfDay) async {
    LocalStorage.setDawnNotificationTime(timeOfDay);
    LocalStorage.setDawnNotifications(true);
    masaaTime = timeOfDay;
    isMasaaActive = true;
    NotificationsService.setAzkarNotification(dawnNotificationId);
    notifyListeners();
  }

  Future<void> activateMorningNotificationsTime(TimeOfDay timeOfDay) async {
    await LocalStorage.setMorningNotificationTime(timeOfDay);
    await LocalStorage.setMorningNotifications(true);
    sabahTime = timeOfDay;
    isSabahActive = true;
    NotificationsService.setAzkarNotification(morningNotificationId);
    notifyListeners();
  }

  Future<void> setIsFontMed(bool value) async {
    isFontMed = value;
    LocalStorage.setFontMed(value);
    notifyListeners();
  }

  Future<void> setFirstTime(bool isDark) async {
    firstTime = false;
    notifyListeners();
    LocalStorage.setFirstTime();
    if (!(await LocalStorage.isFridayNotificationsSet())) {
      await NotificationsService.setWeeklyFridayNotification();
    }

    await NotificationsService.initializeFirebaseNotifications(true);

    HomeWidget.requestPinWidget(
        androidName:
            isDark ? 'PrayerTimesSecondDarkWidget' : 'PrayerTimesSecondWidget');
    notifyListeners();
  }
}
