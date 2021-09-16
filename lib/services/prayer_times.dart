import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rayhan/utilities/helper.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayerTimes {
  static double longitude;
  static double latitude;

  static Future<void> getCurrentLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      longitude = pos.longitude;
      latitude = pos.latitude;
    } catch (e) {
      print(e);
    }

    return;
  }

  static Future<dynamic> getData() async {
    await getCurrentLocation();
    Uri uri = Uri.parse(
        'http://api.aladhan.com/v1/timings?latitude=${latitude}&longitude=${longitude}&method=5');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var prayerTimes = SetPrayerTimes(decodedData);
      return prayerTimes;
    } else
      print(response.statusCode);
  }

  static Map<String, String> SetPrayerTimes(var decodedData) {
    Map<String, String> prayerTimes = {
      'Fajr': '',
      'Sunrise': '',
      'Dhuhr': '',
      'Asr': '',
      'Maghrib': '',
      'Isha': '',
    };
    for (String key in prayerTimes.keys) {
      prayerTimes[key] = getArabicNumber(
              int.parse(decodedData["data"]["timings"][key][0])) +
          getArabicNumber(int.parse(decodedData["data"]["timings"][key][1])) +
          ':' +
          getArabicNumber(int.parse(decodedData["data"]["timings"][key][3])) +
          getArabicNumber(int.parse(decodedData["data"]["timings"][key][4]));
    }
    return prayerTimes;
  }
}
