import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as sch;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/screens/azkar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import "dart:math";

class Settings extends ChangeNotifier {
  final String _sabahNotifyTitle = 'أذكار الصباح';
  String _sabahNotifyBody =
      azkarMessageBody[Random().nextInt(azkarMessageBody.length)] +
          '.\nاضغط على الإشعار لقراءة أذكار الصباح.';
  final String _masaaNotifyTitle = 'أذكار المساء';
  String _masaaNotifyBody =
      azkarMessageBody[Random().nextInt(azkarMessageBody.length)] +
          '.\nاضغط على الإشعار لقراءة أذكار المساء.';

  bool isSabahActive;
  bool isMasaaActive;
  int masaaHours;
  int masaaMinutes;
  int sabahHours;
  int sabahMinutes;
  SharedPreferences prefs;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var initializationSettings;
  BuildContext context;

  bool isFontMed;

  bool isNightTheme;
  bool isGreenTheme;

  bool firstTime;

  Future<void> initializeSettings(BuildContext context) async {
    //variables initializations
    this.context = context;

    _initializeScaleFactor(context);

    _sabahNotifyBody =
        azkarMessageBody[Random().nextInt(azkarMessageBody.length)] +
            '.\nاضغط على الإشعار لقراءة أذكار الصباح.';
    _masaaNotifyBody =
        azkarMessageBody[Random().nextInt(azkarMessageBody.length)] +
            '.\nاضغط على الإشعار لقراءة أذكار المساء.';

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    prefs = await SharedPreferences.getInstance();

    firstTime = false;
    if (prefs.getBool('firsTime') == null) {
      firstTime = true;
    }

    if (prefs.getBool('isGreenTheme') == null) {
      prefs.setBool('isGreenTheme', true);
      isGreenTheme = true;
    } else {
      isGreenTheme = prefs.getBool('isGreenTheme');
    }

    if (prefs.getBool('isNightTheme') == null) {
      var brightness = sch.SchedulerBinding.instance.window.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;
      if (isDarkMode) {
        isNightTheme = true;
        prefs.setBool('isNightTheme', true);
      } else {
        isNightTheme = false;
        prefs.setBool('isNightTheme', false);
      }
    } else {
      isNightTheme = prefs.getBool('isNightTheme');
    }

    if (prefs.getBool('isFontMed') == null) {
      prefs.setBool('isFontMed', true);
      isFontMed = true;
    } else {
      isFontMed = prefs.getBool('isFontMed');
    }

    if (prefs.getBool('fridayNotifiation') == null) {
      _setWeeklyFridayNotification();
    }

    if (prefs.getBool('isSabahActive') == null) {
      prefs.setBool('isSabahActive', false);
    }
    if (prefs.getBool('isMasaaActive') == null) {
      prefs.setBool('isMasaaActive', false);
    }
    if (prefs.getInt('sabahHours') != null) {
      sabahHours = prefs.getInt('sabahHours');
    }
    if (prefs.getInt('sabahMinutes') != null) {
      sabahMinutes = prefs.getInt('sabahMinutes');
    }
    if (prefs.getInt('masaaHours') != null) {
      masaaHours = prefs.getInt('masaaHours');
    }
    if (prefs.getInt('masaaMinutes') != null) {
      masaaMinutes = prefs.getInt('masaaMinutes');
    }
    isSabahActive = prefs.getBool('isSabahActive');
    isMasaaActive = prefs.getBool('isMasaaActive');

    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (PendingNotificationRequest not in pendingNotificationRequests) {
      if (not.id == notificationsIDs.masaaNotificationID.index) {
        isMasaaActive = true;
        prefs.setBool('isMasaaActive', isMasaaActive);
      }
      if (not.id == notificationsIDs.sabahNotificationID.index) {
        isSabahActive = true;
        prefs.setBool('isSabahActive', isSabahActive);
      }
      if (not.id == 7 && prefs.getBool('fridayNotifiation') == null) {
        prefs.setBool('fridayNotification', true);
      }
    }

    if (isSabahActive) {
      setNotification(
          notificationsIDs.sabahNotificationID.index, sabahHours, sabahMinutes);
    }
    if (isMasaaActive) {
      setNotification(
          notificationsIDs.masaaNotificationID.index, masaaHours, masaaMinutes);
    }

    await Future.delayed(Duration(seconds: 3));

    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails.payload == 'أذكار الصباح') {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AzkarScreen(
            title: 'أذكار الصباح',
          ),
        ),
      );
    } else if (notificationAppLaunchDetails.payload == 'أذكار المساء') {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AzkarScreen(
            title: 'أذكار المساء',
          ),
        ),
      );
    }

    return;
  }

  void setNotification(int id, int hours, int minutes) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AzkarScreen(
            title: payload,
          ),
        ),
      );
    });

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        notificationsIDs.sabahNotificationID.index == id
            ? _sabahNotifyTitle
            : _masaaNotifyTitle,
        notificationsIDs.sabahNotificationID.index == id
            ? _sabahNotifyBody
            : _masaaNotifyBody,
        _nextInstanceOfTime(hours, minutes),
        NotificationDetails(
          android: AndroidNotificationDetails(
            notificationsIDs.sabahNotificationID.index == id
                ? _sabahNotifyTitle
                : _masaaNotifyTitle,
            'روحٌ وريحان',
            'إشعارات يومية لأذكار الصباح والمساء',
            playSound: true,
            sound: RawResourceAndroidNotificationSound('notify'),
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(''),
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: notificationsIDs.sabahNotificationID.index == id
            ? _sabahNotifyTitle
            : _masaaNotifyTitle,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTime(int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print(tz.local);
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
    print(scheduledDate);
    return scheduledDate;
  }

  void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    if (id == notificationsIDs.sabahNotificationID.index) {
      prefs.setBool('isSabahActive', false);
      isSabahActive = false;
    } else {
      prefs.setBool('isMasaaActive', false);
      isMasaaActive = false;
    }
  }

  void setPreferences(String notificationKey, String hoursKey,
      String minutesKey, int hours, int minutes) {
    prefs.setBool(notificationKey, true);
    prefs.setInt(hoursKey, hours);
    prefs.setInt(minutesKey, minutes);
    if (notificationKey == 'isSabahActive') {
      isSabahActive = true;
      sabahHours = hours;
      sabahMinutes = minutes;
    } else {
      isMasaaActive = true;
      masaaHours = hours;
      masaaMinutes = minutes;
    }
    notifyListeners();
  }

  Future<void> setFontSize(int index) async {
    isFontMed = index == 1 ? false : true;
    await prefs.setBool('isFontMed', isFontMed);
    notifyListeners();
  }

  Future<void> setNightTheme() async {
    isNightTheme = true;
    isGreenTheme = true;
    prefs.setBool('isNightTheme', true);
    prefs.setBool('isGreenTheme', true);
    notifyListeners();
  }

  Future<void> setGreenTheme() async {
    isNightTheme = false;
    isGreenTheme = true;
    prefs.setBool('isNightTheme', false);
    prefs.setBool('isGreenTheme', true);
    notifyListeners();
  }

  Future<void> setBlueTheme() async {
    isNightTheme = false;
    isGreenTheme = false;
    prefs.setBool('isNightTheme', false);
    prefs.setBool('isGreenTheme', false);
    notifyListeners();
  }

  Future<void> setFirstTime() async {
    firstTime = false;
    prefs.setBool('firsTime', false);
    notifyListeners();
  }

  Future<void> _setWeeklyFridayNotification() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {});
    await flutterLocalNotificationsPlugin.zonedSchedule(
        7,
        'دعاء يوم الجمعة',
        'قَالَ رسُولُ اللَّهِ ﷺ: "إِنَّ مِنْ أَفضَلِ أَيَّامِكُمْ يَوْم الجُمُعَةِ، فأَكثروا عليَّ مِنَ الصَّلاةِ فِيهِ، فَإِنَّ صَلاتَكُمْ مَعْروضَةٌ عليَّ"\n وقَالَ رسُولُ اللَّهِ ﷺ عن يوم الجمعة: "فيهِ ساعَةٌ لا يُوَافِقُها عَبْدٌ مُسْلِمٌ وَهُوَ قَائِمٌ يُصَلِّي يَسألُ اللَّهَ تَعالى شَيْئاً إِلاَّ أعْطاهُ إيَّاهُ".',
        _nextInstanceOfFriday(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'إشعار يوم الجمعة',
            'إشعار يوم الجمعة',
            'إشعار للتذكير بالدعاء يوم الجمعة',
            playSound: true,
            sound: RawResourceAndroidNotificationSound('notify'),
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(''),
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'إشعار يوم الجمعة',
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextInstanceOfFriday() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 15, 00);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    while (scheduledDate.weekday != DateTime.sunday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate);
    return scheduledDate;
  }

  void _initializeScaleFactor(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / kReferenceWidth;

    double heightRatio = (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom) /
        kReferenceHeight;

    if (widthRatio > 1.5) {
      widthRatio = 1.3;
    } else if (widthRatio > 1.1) {
      widthRatio = 1.1;
    }
    if (heightRatio > 1.5) {
      heightRatio = 1.3;
    } else if (heightRatio > 1.1) {
      heightRatio = 1.1;
    }

    if (widthRatio < 0.9) {
      widthRatio = 0.9;
    }
    if (heightRatio < 0.9) {
      heightRatio = 0.9;
    }

    sizeRatio = heightRatio * widthRatio;
  }
}
