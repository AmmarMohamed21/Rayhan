import 'package:flutter/material.dart';
import 'package:rayhan/utilities/constants.dart';

import '../services/local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;
  String? currentThemeName;
  double sizeRatio = 1.0;

  final ThemeData lightBlue = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Harmattans',
    primaryColor: kBluePrimaryColor,
    primaryColorLight: kBlueLightColor,
    primaryColorDark: kBlueDarkColor,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: kLightBackgroundColor,
      dialHandColor: kBluePrimaryColor,
      dialBackgroundColor: kBlueLightColor.withOpacity(0.1),
      dialTextColor: kBlueDarkColor,
      dayPeriodColor: kBlueLightColor,
      dayPeriodTextColor: kBlueDarkColor,
      entryModeIconColor: kBlueDarkColor,
      hourMinuteColor: kBlueLightColor.withOpacity(0.1),
      hourMinuteTextColor: kBlueDarkColor,
      helpTextStyle: TextStyle(
        color: kBlueDarkColor,
        fontSize: 16.0,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kBluePrimaryColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kBluePrimaryColor,
            fontSize: 16.0,
          ),
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kBlueDarkColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kBlueDarkColor,
            fontSize: 16.0,
          ),
        ),
      ),
    ),
    scaffoldBackgroundColor: kLightBackgroundColor,
  );

  final ThemeData lightGreen = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Harmattans',
    primaryColor: kGreenPrimaryColor,
    primaryColorLight: kGreenLightColor,
    primaryColorDark: kGreenDarkColor,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: kLightBackgroundColor,
      dialHandColor: kGreenPrimaryColor,
      dialBackgroundColor: kGreenLightColor.withOpacity(0.1),
      dialTextColor: kGreenDarkColor,
      dayPeriodColor: kGreenLightColor,
      dayPeriodTextColor: kGreenDarkColor,
      entryModeIconColor: kGreenDarkColor,
      hourMinuteColor: kGreenLightColor.withOpacity(0.1),
      hourMinuteTextColor: kGreenDarkColor,
      helpTextStyle: TextStyle(
        color: kGreenDarkColor,
        fontSize: 16.0,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kGreenPrimaryColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kGreenPrimaryColor,
            fontSize: 16.0,
          ),
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kGreenDarkColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kGreenDarkColor,
            fontSize: 16.0,
          ),
        ),
      ),
    ),
    scaffoldBackgroundColor: kLightBackgroundColor,
  );

  final ThemeData darkGreen = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Harmattans',
    primaryColor: kGreenPrimaryColor,
    primaryColorLight: kGreenLightColor,
    primaryColorDark: kGreenDarkColor,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: kDarkBackgroundColor,
      dialHandColor: kGreenPrimaryColor,
      dialBackgroundColor: kGreenLightColor.withOpacity(0.1),
      dialTextColor: Colors.white,
      dayPeriodColor: kGreenDarkColor,
      dayPeriodTextColor: Colors.white,
      entryModeIconColor: kGreenLightColor,
      hourMinuteColor: kGreenLightColor.withOpacity(0.1),
      hourMinuteTextColor: Colors.white,
      helpTextStyle: TextStyle(
        color: kGreenLightColor,
        fontSize: 16.0,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kGreenLightColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kGreenLightColor,
            fontSize: 16.0,
          ),
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(kGreenLightColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: kGreenLightColor,
            fontSize: 16.0,
          ),
        ),
      ),
    ),
    scaffoldBackgroundColor: kDarkBackgroundColor,
  );

  Future<void> initTheme(BuildContext context) async {
    _initializeScaleFactor(context);
    String? theme = await LocalStorage.getTheme();
    if (theme == null) {
      bool isDarkMode =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      if (isDarkMode) {
        currentTheme = darkGreen;
        currentThemeName = 'darkGreen';
      } else {
        currentTheme = lightGreen;
        currentThemeName = 'lightGreen';
      }
    } else {
      currentThemeName = theme;
      if (theme == 'lightBlue') {
        currentTheme = lightBlue;
      } else if (theme == 'lightGreen') {
        currentTheme = lightGreen;
      } else {
        currentTheme = darkGreen;
      }
    }

    notifyListeners();
  }

  void changeTheme(String theme) {
    if (theme == 'lightBlue') {
      currentTheme = lightBlue;
    } else if (theme == 'lightGreen') {
      currentTheme = lightGreen;
    } else {
      currentTheme = darkGreen;
    }
    currentThemeName = theme;
    notifyListeners();
    LocalStorage.saveTheme(theme);
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
