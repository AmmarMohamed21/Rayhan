import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rayhan/screens/about_screen.dart';
import 'package:rayhan/screens/prayer_times_screen.dart';

import 'package:rayhan/screens/settings_screen.dart';
import 'constants.dart';
import 'screens/home_screen.dart';

import 'services/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Settings(),
      child: MaterialApp(
        title: 'روحٌ وريحان',
        theme: ThemeData(
          fontFamily: 'Harmattans',
          // highlightColor: Provider.of<Notifications>(context).isBlueTheme
          //     ? kBLightColor
          //     : kGLightColor,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar', 'EG'),
        ],
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          PrayerTimesScreen.id: (context) => PrayerTimesScreen(),
          AboutScreen.id: (context) => AboutScreen(),
        },
      ),
    );
  }
}
