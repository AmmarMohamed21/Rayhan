import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rayhan/models/azkar_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/monthly_prayer_times.dart';

class LocalStorage {
  // static Future<void> saveTheme(String theme) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('theme', theme);
  // }
  //
  // static Future<String?> getTheme() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('theme');
  // }

  static Future<bool> isAutoTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('autoTheme') ?? true;
  }

  static Future<void> setAutoTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoTheme', value);
  }

  static Future<bool> isDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkTheme') ?? false;
  }

  static Future<void> setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', value);
  }

  static Future<bool> isFridayNotificationsSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('fridayNotification') ?? false;
  }

  static Future<void> setFridayNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fridayNotification', true);
  }

  static Future<TimeOfDay?> getMorningNotificationTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? hour = prefs.getInt('morningNotificationHour');
    int? minute = prefs.getInt('morningNotificationMinute');
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  static Future<void> setMorningNotificationTime(TimeOfDay time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('morningNotificationHour', time.hour);
    await prefs.setInt('morningNotificationMinute', time.minute);
  }

  static Future<TimeOfDay?> getDawnNotificationTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? hour = prefs.getInt('dawnNotificationHour');
    int? minute = prefs.getInt('dawnNotificationMinute');
    if (hour == null || minute == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  static Future<void> setDawnNotificationTime(TimeOfDay time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dawnNotificationHour', time.hour);
    await prefs.setInt('dawnNotificationMinute', time.minute);
  }

  static Future<bool> isMorningNotificationsSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('morningNotification') ?? false;
  }

  static Future<void> setMorningNotifications(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('morningNotification', value);
  }

  static Future<bool> isDawnNotificationsSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dawnNotification') ?? false;
  }

  static Future<void> setDawnNotifications(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dawnNotification', value);
  }

  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstTime') ?? true;
  }

  static Future<void> setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstTime', false);
  }

  static Future<void> setFontMed(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFontMed', value);
  }

  static Future<bool> isFontMed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFontMed') ?? true;
  }

  static Future<bool> isFajrNotificationSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('fajrNotification') ?? false;
  }

  static Future<void> setFajrNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fajrNotification', value);
  }

  static Future<MonthlyPrayerTimes?> getCachedPrayerTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('monthlyPrayerTimes')) {
      return null;
    }
    return MonthlyPrayerTimes.fromJson(
        jsonDecode(prefs.getString('monthlyPrayerTimes')!));
  }

  static Future<void> cachePrayerTimes(MonthlyPrayerTimes prayerTimes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'monthlyPrayerTimes', jsonEncode(prayerTimes.toJson()));
  }

  static Future<void> saveAzkarList(AzkarList azkarList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('azkarList', jsonEncode(azkarList.toJson()));
  }

  static Future<AzkarList?> getAzkarList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('azkarList')) {
      return null;
    }
    return AzkarList.fromJson(jsonDecode(prefs.getString('azkarList')!));
  }
}
