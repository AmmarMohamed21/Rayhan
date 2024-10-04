import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rayhan/models/monthly_prayer_times.dart';
import 'package:rayhan/services/crashlytics_service.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../utilities/constants.dart';
import 'local_storage.dart';

class NotificationsService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const InitializationSettings initializationSettings =
      InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/launcher_icon"),
          iOS: DarwinInitializationSettings(
            defaultPresentAlert: true,
            defaultPresentBadge: true,
            defaultPresentSound: true,
          ));

  static Future<void> initializeFirebaseNotifications(bool isFirstTime) async {
    try {
      if (!isFirstTime) {
        NotificationSettings settings =
            await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        log('User granted permission: ${settings.authorizationStatus}');
      }

      if (isFirstTime) {
        FirebaseMessaging.instance.subscribeToTopic("all");
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          showNormalNotification(
              title: message.notification?.title ?? "",
              body: message.notification?.body ?? "");
        });
      }
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
    }
  }

  static Future<void> setWeeklyFridayNotification() async {
    try {
      await notificationsPlugin.initialize(initializationSettings);

      bool? result = await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      if (result != true) {
        return;
      }

      tz.initializeTimeZones();
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));

      await notificationsPlugin.zonedSchedule(
          7,
          'دعاء يوم الجمعة',
          'قَالَ رسُولُ اللَّهِ ﷺ: "إِنَّ مِنْ أَفضَلِ أَيَّامِكُمْ يَوْم الجُمُعَةِ، فأَكثروا عليَّ مِنَ الصَّلاةِ فِيهِ، فَإِنَّ صَلاتَكُمْ مَعْروضَةٌ عليَّ"\n وقَالَ رسُولُ اللَّهِ ﷺ عن يوم الجمعة: "فيهِ ساعَةٌ لا يُوَافِقُها عَبْدٌ مُسْلِمٌ وَهُوَ قَائِمٌ يُصَلِّي يَسألُ اللَّهَ تَعالى شَيْئاً إِلاَّ أعْطاهُ إيَّاهُ".',
          _nextInstanceOfFriday(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'إشعار يوم الجمعة',
              'إشعار يوم الجمعة',
              channelDescription: 'إشعار للتذكير بالدعاء يوم الجمعة',
              playSound: true,
              sound: const RawResourceAndroidNotificationSound('notify'),
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: BigTextStyleInformation(''),
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: 'إشعار يوم الجمعة',
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
    }
  }

  static tz.TZDateTime _nextInstanceOfFriday() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 15);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    while (scheduledDate.weekday != DateTime.friday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static Future<void> setAzkarNotification(int id) async {
    try {
      await notificationsPlugin.initialize(initializationSettings);

      tz.initializeTimeZones();
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));

      TimeOfDay? notificationTime = morningNotificationId == id
          ? await LocalStorage.getMorningNotificationTime()
          : await LocalStorage.getDawnNotificationTime();

      if (notificationTime == null) {
        return;
      }

      String masaaNotifyBody =
          '${azkarMessageBody[math.Random().nextInt(azkarMessageBody.length)]}.\nاضغط على الإشعار لقراءة أذكار المساء.';
      String sabahNotifyBody =
          '${azkarMessageBody[math.Random().nextInt(azkarMessageBody.length)]}.\nاضغط على الإشعار لقراءة أذكار الصباح.';
      log('notificationTime: ${notificationTime.toString()}');

      await notificationsPlugin.zonedSchedule(
        id,
        morningNotificationId == id ? sabahNotifyTitle : masaaNotifyTitle,
        morningNotificationId == id ? sabahNotifyBody : masaaNotifyBody,
        _nextInstanceOfTime(notificationTime.hour, notificationTime.minute),
        NotificationDetails(
          android: AndroidNotificationDetails(
            morningNotificationId == id ? sabahNotifyTitle : masaaNotifyTitle,
            'روحٌ وريحان',
            channelDescription: 'إشعارات يومية لأذكار الصباح والمساء',
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('notify'),
            importance: Importance.max,
            priority: Priority.max,
            styleInformation: BigTextStyleInformation(''),
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload:
            morningNotificationId == id ? sabahNotifyTitle : masaaNotifyTitle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
    }
  }

  static tz.TZDateTime _nextInstanceOfTime(int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hours,
      minutes,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    log('scheduledDate: ${scheduledDate.toString()}');
    return scheduledDate;
  }

  static Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  static Future<void> showNormalNotification({
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.initialize(initializationSettings);

    await notificationsPlugin.show(
      10,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'روحٌ وريحان',
          'روحٌ وريحان',
          channelDescription: 'إشعارات عامة',
          playSound: true,
          sound: const RawResourceAndroidNotificationSound('notify'),
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(''),
        ),
      ),
      payload: 'روحٌ وريحان',
    );
  }

  static Future<void> updateFajrNotification() async {
    if (!await LocalStorage.isFajrNotificationSet()) {
      return;
    }

    MonthlyPrayerTimes? cachedPrayerTimes =
        await LocalStorage.getCachedPrayerTimes();
    if (cachedPrayerTimes == null ||
        !cachedPrayerTimes.monthYear.isSameMonth(DateTime.now())) {
      return;
    }

    try {
      await notificationsPlugin.initialize(initializationSettings);

      tz.initializeTimeZones();
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));

      TimeOfDay notificationTime = cachedPrayerTimes
          .prayerTimes[DateTime.now().day - 1].fajr
          .toTimeOfDay();

      await notificationsPlugin.zonedSchedule(
        fajrNotificationId,
        fajrNotifyTitle,
        fajrNotifyBody,
        _nextInstanceOfTime(notificationTime.hour, notificationTime.minute),
        NotificationDetails(
          android: AndroidNotificationDetails(
            fajrNotifyTitle,
            'روحٌ وريحان',
            channelDescription: 'منبه إلى صلاة الفجر',
            playSound: true,
            sound: const RawResourceAndroidNotificationSound('adhan'),
            importance: Importance.max,
            priority: Priority.max,
            styleInformation: BigTextStyleInformation(''),
            audioAttributesUsage: AudioAttributesUsage.alarm,
            autoCancel: false,
            category: AndroidNotificationCategory.alarm,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
    }
  }
}
