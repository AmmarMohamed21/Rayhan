import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rayhan/models/monthly_prayer_times.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';

import '../models/prayer_times.dart';

String getArabicNumber(int num) {
  String arabicNum = '';
  arabicNum = arabicNumbers[num % 10]!;
  if (num >= 10) {
    arabicNum = arabicNumbers[num % 100 ~/ 10]! + arabicNum;
  }
  if (num >= 100) {
    arabicNum = arabicNumbers[num % 1000 ~/ 100]! + arabicNum;
  }
  if (num >= 1000) {
    arabicNum = arabicNumbers[num % 10000 ~/ 1000]! + arabicNum;
  }
  return arabicNum;
}

String addZeroToSingleDigit(String number) {
  if (number.length == 1) {
    number = '٠$number';
  }
  return number;
}

String getSubtitle(int notificationId, BuildContext context) {
  int hours;
  int minutes;
  if (notificationId == morningNotificationId) {
    hours =
        Provider.of<SettingsProvider>(context, listen: false).sabahTime!.hour;
    minutes =
        Provider.of<SettingsProvider>(context, listen: false).sabahTime!.minute;
  } else {
    hours =
        Provider.of<SettingsProvider>(context, listen: false).masaaTime!.hour;
    minutes =
        Provider.of<SettingsProvider>(context, listen: false).masaaTime!.minute;
  }
  return 'وقت الإشعار اليومي: ${addZeroToSingleDigit(getArabicNumber(hours))}:${addZeroToSingleDigit(getArabicNumber(minutes))}';
}

double calculateDistanceInMeters(
    double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000; // Earth's radius in meters

  // Convert degrees to radians
  double lat1Rad = lat1 * (pi / 180);
  double lon1Rad = lon1 * (pi / 180);
  double lat2Rad = lat2 * (pi / 180);
  double lon2Rad = lon2 * (pi / 180);

  // Haversine formula
  double dLat = lat2Rad - lat1Rad;
  double dLon = lon2Rad - lon1Rad;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate the distance
  double distance = earthRadius * c;

  return distance;
}

Duration getNextMidnight(int minutesOffset) {
  DateTime now = DateTime.now();
  DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
  nextMidnight = nextMidnight.add(Duration(minutes: minutesOffset));
  return nextMidnight.difference(now);
}

Future<bool> isInternet() async {
  List<ConnectivityResult> connectivityResults =
      await Connectivity().checkConnectivity();
  if (connectivityResults.first == ConnectivityResult.none) {
    return false;
  }
  try {
    final result = await http.head(Uri.parse('https://www.google.com')).timeout(
      const Duration(seconds: 25),
      onTimeout: () {
        throw Exception('no internet');
      },
    );
    return result.statusCode.toString().startsWith('2');
  } on SocketException catch (e) {
    return false;
  } catch (e) {
    return false;
  }
}

bool isDateForCorrection(MonthlyPrayerTimes monthlyPrayerTimes) {
  int currentDayIndex = DateTime.now().day - 1;
  PrayerTimes prayerTimes = monthlyPrayerTimes.prayerTimes[currentDayIndex];
  DateTime hijriDate = prayerTimes.hijriDate;
  if (hijriDate.day == 29 ||
      hijriDate.day == 30 ||
      hijriDate.day == 1 ||
      hijriDate.day == 2) {
    return true;
  }
  return false;
}
