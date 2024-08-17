import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/theme_provider.dart';
import 'package:rayhan/screens/about_screen.dart';
import 'package:rayhan/screens/loading_screen.dart';
import 'package:rayhan/screens/prayer_times_screen.dart';
import 'package:rayhan/screens/settings_screen.dart';
import 'package:rayhan/services/local_storage.dart';
import 'package:rayhan/services/notifications_service.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:workmanager/workmanager.dart';

import 'providers/prayer_times_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (await LocalStorage.isDawnNotificationsSet()) {
        await NotificationsService.setAzkarNotification(
            NotificationIDs.dawnNotificationID.index);
      }
      if (await LocalStorage.isMorningNotificationsSet()) {
        await NotificationsService.setAzkarNotification(
            NotificationIDs.morningNotificationID.index);
      }
    } catch (e, st) {
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
  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    // isInDebugMode:
    //     true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerPeriodicTask(
    "dailyNotifRandom",
    "dailyNotifRandom",
    frequency: const Duration(hours: 24),
    initialDelay: const Duration(seconds: 10),
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
