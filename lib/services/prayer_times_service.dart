import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:rayhan/utilities/helper.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';

import '../models/monthly_prayer_times.dart';
import 'crashlytics_service.dart';

class PrayerTimesService {
  static Future<Position?> getLastKnownPosition() async {
    try {
      print("Getting last known geolocation");
      Position? pos = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true,
      ).timeout(Duration(seconds: 10));
      print("Position timestamp: ${pos?.timestamp}");
      print("Position longitude: ${pos?.longitude}");
      print("Position latitude: ${pos?.latitude}");
      return pos;
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st);
      log("Error: $e");
    }
    return null;
  }

  static Future<Position?> getCurrentLocation() async {
    try {
      print("Getting geolocation");
      Position pos = await Geolocator.getCurrentPosition(
          locationSettings: AndroidSettings(
        forceLocationManager: true,
        accuracy: LocationAccuracy.high,
        distanceFilter: 3000,
        timeLimit: Duration(seconds: 60),
      ));
      log("Position timestamp: ${pos.timestamp}");
      log("Position longitude: ${pos.longitude}");
      log("Position latitude: ${pos.latitude}");
      return pos;
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st);
      log("Error: $e");
    }
    return null;
  }

  static Future<String?> _getCityName(double latitude, double longitude) async {
    CrashlyticsService.log("latitude: $latitude, longitude: $longitude");
    try {
      await setLocaleIdentifier("ar");
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      ).timeout(Duration(seconds: 45));
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return await _formatString(placemark);
      }
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
      log("Error: $e");
    }

    return null;
  }

  static Future<String> _formatString(Placemark placemark) async {
    String adminArea = placemark.administrativeArea ?? '';
    String subAdminArea = placemark.subAdministrativeArea ?? '';
    String locality = placemark.locality ?? '';

    adminArea = adminArea.replaceAll("محافظة ", "");
    subAdminArea = subAdminArea.replaceAll("قسم أول ", "");
    subAdminArea = subAdminArea.replaceAll("قسم ثاني ", "");
    subAdminArea = subAdminArea.replaceAll("قسم ثانى ", "");
    subAdminArea = subAdminArea.replaceAll("قسم ثان ", "");
    subAdminArea = subAdminArea.replaceAll("قسم ثالث ", "");
    subAdminArea = subAdminArea.replaceAll("قسم ", "");
    subAdminArea = subAdminArea.replaceAll("مركز ", "");
    subAdminArea = subAdminArea.replaceAll("أول ", "");
    subAdminArea = subAdminArea.replaceAll("ثاني ", "");
    subAdminArea = subAdminArea.replaceAll("ثانى ", "");

    List<String> parts = [];
    if (subAdminArea.isNotEmpty) {
      parts.add(subAdminArea.trim());
    } else if (locality.isNotEmpty) {
      parts.add(locality.trim());
    }
    if (adminArea.isNotEmpty) {
      parts.add(adminArea.trim());
    }

    String result = parts.join("، ");
    print(result);
    return result;
  }

  static Future<MonthlyPrayerTimes?> getPrayerTimes(
      double latitude, double longitude, DateTime locationTimestamp) async {
    CrashlyticsService.log("latitude: $latitude, longitude: $longitude");
    DateTime now = DateTime.now();
    try {
      Uri uri = Uri.parse(
          'http://api.aladhan.com/v1/calendar/${now.year}/${now.month}?latitude=$latitude&longitude=$longitude');
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        String data = response.body;
        String city = await _getCityName(latitude, longitude) ?? "";
        MonthlyPrayerTimes monthlyPrayerTimes = MonthlyPrayerTimes.fromJson(
            _decodeData(data, latitude, longitude, locationTimestamp, city));
        //TODO: correct hijri date
        return monthlyPrayerTimes;
      }
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
      log("Error: $e");
    }

    return null;
  }

  static Map<String, dynamic> _decodeData(String data, double latitude,
      double longitude, DateTime locationTimestamp, String city) {
    Map<String, dynamic> json = jsonDecode(data);
    List<String> prayerKeys = [
      'Fajr',
      'Sunrise',
      'Dhuhr',
      'Asr',
      'Maghrib',
      'Isha'
    ];

    json["PrayerTimes"] = [];

    for (var obj in json["data"]) {
      Map<String, dynamic> prayerBody = {};
      for (String key in prayerKeys) {
        prayerBody[key] = getArabicNumber(int.parse(obj["timings"][key][0])) +
            getArabicNumber(int.parse(obj["timings"][key][1])) +
            ':' +
            getArabicNumber(int.parse(obj["timings"][key][3])) +
            getArabicNumber(int.parse(obj["timings"][key][4]));
      }
      prayerBody["ArabicDayName"] = obj["date"]["hijri"]["weekday"]["ar"];
      prayerBody["HijriDate"] = obj["date"]["hijri"]["date"].toString();
      // prayerBody["ArabicDate"] =
      //     "${getArabicNumber(int.parse(obj["date"]["hijri"]["day"]))} ${obj["date"]["hijri"]["month"]["ar"]} ${getArabicNumber(int.parse(obj["date"]["hijri"]["year"]))}";
      prayerBody["Date"] = obj["date"]["gregorian"]["date"]
          .toString()
          .toDateTime()
          .toIso8601String();

      json["PrayerTimes"].add(prayerBody);
    }

    json["City"] = city;
    json["LocationTimestamp"] = locationTimestamp.toIso8601String();
    json["Latitude"] = latitude;
    json["Longitude"] = longitude;
    json["MonthYear"] = DateTime.now().toIso8601String();
    return json;
  }
}
