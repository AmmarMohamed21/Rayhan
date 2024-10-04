import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rayhan/utilities/parsing_extensions.dart';

import '../models/monthly_prayer_times.dart';
import '../models/prayer_times.dart';
import 'crashlytics_service.dart';

class HijriDateService {
  static Future<MonthlyPrayerTimes> correctHijriDate(
      MonthlyPrayerTimes currentPrayerTimes) async {
    DateTime now = DateTime.now();
    PrayerTimes todayPrayerTimes = currentPrayerTimes.prayerTimes[now.day - 1];
    try {
      Uri uri = Uri.parse(
          'https://www.islamicfinder.us/index.php/api/calendar?day=${now.day}&month=${now.month}&year=${now.year}&convert_to=0');
      http.Response response =
          await http.get(uri).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        String data = response.body;
        DateTime returnedHijriDate =
            jsonDecode(data)['to'].toString().toDateTime();

        if (returnedHijriDate.isSameDate(todayPrayerTimes.hijriDate)) {
          return currentPrayerTimes;
        } else {
          MonthlyPrayerTimes correctedPrayerTimes =
              currentPrayerTimes.copyWith();
          correctedPrayerTimes.prayerTimes[now.day - 1] = currentPrayerTimes
              .prayerTimes[now.day - 1]
              .copyWith(hijriDate: returnedHijriDate);
          for (int day = now.day + 1;
              day <= currentPrayerTimes.prayerTimes.length;
              day++) {
            returnedHijriDate = returnedHijriDate.add(Duration(days: 1));
            correctedPrayerTimes.prayerTimes[day - 1] = currentPrayerTimes
                .prayerTimes[day - 1]
                .copyWith(hijriDate: returnedHijriDate);
          }
          return correctedPrayerTimes;
        }
      }
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st);
      log(e.toString());
    }
    return currentPrayerTimes;
  }
}
