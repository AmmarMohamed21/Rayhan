import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rayhan/utilities/helper.dart';

class PrayerTimes {
  static double _longitude;
  static double _latitude;

  static Future<void> _getCurrentLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _longitude = pos.longitude;
      _latitude = pos.latitude;
    } catch (e) {}

    return;
  }

  static Future<dynamic> getData() async {
    await _getCurrentLocation();
    Uri uri = Uri.parse(
        'http://api.aladhan.com/v1/timings?latitude=${_latitude}&longitude=${_longitude}&method=5');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var prayerTimes = _SetPrayerTimes(decodedData);
      return prayerTimes;
    }
    return;
  }

  static Map<String, String> _SetPrayerTimes(var decodedData) {
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
