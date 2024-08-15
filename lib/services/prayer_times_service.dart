import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:rayhan/utilities/helper.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';

import '../models/prayer_times.dart';

class PrayerTimesService {
  static Future<Position?> getCurrentLocation() async {
    try {
      print("Getting geolocation");
      Position pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 3000,
        timeLimit: Duration(seconds: 60),
      ));
      print("Position timestamp: ${pos.timestamp}");
      print("Position longitude: ${pos.longitude}");
      print("Position latitude: ${pos.latitude}");
      return pos;
    } catch (e, st) {
      print("Error: $e");
      print("Stacktrace: $st");
    }
    return null;
  }

  static Future<String?> _getCityName(Position pos) async {
    try {
      await setLocaleIdentifier('ar');
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return await _formatString(placemark);
      }
    } catch (e, st) {
      print("Error: $e");
      print("Stacktrace: $st");
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
    print("result");
    print(result);
    return result;
  }

  static Future<PrayerTimes?> getPrayerTimes(Position pos) async {
    try {
      Uri uri = Uri.parse(
          'http://api.aladhan.com/v1/timings?latitude=${pos.latitude}&longitude=${pos.longitude}');
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        String data = response.body;
        String city = await _getCityName(pos) ?? "";
        return PrayerTimes.fromJson(_decodeData(data, pos, city));
      }
    } catch (e, st) {
      print("Error: $e");
      print("Stacktrace: $st");
    }

    return null;
  }

  static Map<String, dynamic> _decodeData(
      String data, Position position, String city) {
    Map<String, dynamic> json = jsonDecode(data);
    List<String> keys = ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    for (String key in keys) {
      json[key] = getArabicNumber(int.parse(json["data"]["timings"][key][0])) +
          getArabicNumber(int.parse(json["data"]["timings"][key][1])) +
          ':' +
          getArabicNumber(int.parse(json["data"]["timings"][key][3])) +
          getArabicNumber(int.parse(json["data"]["timings"][key][4]));
    }
    json["City"] = city;
    json["LocationTimestamp"] = position.timestamp.toIso8601String();
    json["ArabicDayName"] = json["data"]["date"]["hijri"]["weekday"]["ar"];
    json["ArabicDate"] =
        "${getArabicNumber(int.parse(json["data"]["date"]["hijri"]["day"]))} ${json["data"]["date"]["hijri"]["month"]["ar"]} ${getArabicNumber(int.parse(json["data"]["date"]["hijri"]["year"]))}";
    json["Date"] = json["data"]["date"]["gregorian"]["date"]
        .toString()
        .toDateTime()
        .toIso8601String();
    json["Latitude"] = position.latitude;
    json["Longitude"] = position.longitude;
    return json;
  }

  static Future<bool> isInternet() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    if (connectivityResults.first == ConnectivityResult.none) {
      return false;
    }
    try {
      final result =
          await http.head(Uri.parse('https://www.google.com')).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          log("timeout");
          throw Exception('no internet');
        },
      );
      return result.statusCode.toString().startsWith('2');
    } on SocketException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
