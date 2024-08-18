import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/azkar_provider.dart';
import 'package:rayhan/providers/theme_provider.dart';
import 'package:rayhan/screens/about_screen.dart';
import 'package:rayhan/screens/loading_screen.dart';
import 'package:rayhan/screens/prayer_times_screen.dart';
import 'package:rayhan/screens/settings_screen.dart';
import 'package:rayhan/services/crashlytics_service.dart';
import 'package:rayhan/services/daily_refresh_prayer_service.dart';
import 'package:rayhan/services/local_storage.dart';
import 'package:rayhan/services/notifications_service.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';
import 'package:workmanager/workmanager.dart';

import 'providers/prayer_times_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void customCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == "dailyNotifRandom") {
        if (await LocalStorage.isDawnNotificationsSet()) {
          await NotificationsService.setAzkarNotification(
              NotificationIDs.dawnNotificationID.index);
        }
        if (await LocalStorage.isMorningNotificationsSet()) {
          await NotificationsService.setAzkarNotification(
              NotificationIDs.morningNotificationID.index);
        }
      } else if (task == "refreshPrayerTimes") {
        await DailyRefreshPrayerService.refreshPrayerTimes();
      }
    } catch (e, st) {
      CrashlyticsService.log("Error in task $task");
      CrashlyticsService.sendReport(e.toString(), st, true);
      return Future.value(false);
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await Workmanager().initialize(
    customCallbackDispatcher,
  );
  Workmanager().registerPeriodicTask(
    "refreshPrayerTimes",
    "refreshPrayerTimes",
    frequency: const Duration(hours: 24),
    //set initialDelay to be at 12:01 AM every day
    initialDelay: getNextMidnight(1),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  Workmanager().registerPeriodicTask(
    "dailyNotifRandom",
    "dailyNotifRandom",
    frequency: const Duration(hours: 24),
    //set initialDelay to be at 12:10 AM every day
    initialDelay: getNextMidnight(10),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PrayerTimesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AzkarProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'روحٌ وريحان',
        theme: Provider.of<ThemeProvider>(context).currentTheme ??
            ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Harmattans',
              primaryColor: kBluePrimaryColor,
              primaryColorLight: kBlueLightColor,
              primaryColorDark: kBlueDarkColor,
              timePickerTheme: TimePickerThemeData(
                backgroundColor: kLightBackgroundColor,
              ),
              scaffoldBackgroundColor: kLightBackgroundColor,
            ),
        initialRoute: LoadingScreen.id,
        locale: const Locale('ar', 'EG'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'EG'),
        ],
        routes: {
          LoadingScreen.id: (context) => const LoadingScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          PrayerTimesScreen.id: (context) => PrayerTimesScreen(),
          AboutScreen.id: (context) => const AboutScreen(),
        },
      ),
    );
  }
}
