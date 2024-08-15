import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/prayer_times.dart';

class LocalStorage {
  static Future<void> saveTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
  }

  static Future<String?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme');
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

  static Future<PrayerTimes?> getCachedPrayerTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('prayerTimes')) {
      return null;
    }
    return PrayerTimes.fromJson(jsonDecode(prefs.getString('prayerTimes')!));
  }

  static Future<void> cachePrayerTimes(PrayerTimes prayerTimes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('prayerTimes', jsonEncode(prayerTimes.toJson()));
  }
}
