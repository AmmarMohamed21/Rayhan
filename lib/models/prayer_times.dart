import 'package:rayhan/utilities/parsing_extensions.dart';

class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  final DateTime date;
  final String arabicDayName;

  final DateTime hijriDate;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.arabicDayName,
    required this.date,
    required this.hijriDate,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      arabicDayName: json["ArabicDayName"] ?? "",
      date: DateTime.tryParse(json["Date"]) ?? DateTime.now(),
      hijriDate: json["HijriDate"].toString().toDateTime(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Isha': isha,
      'Date': date.toIso8601String(),
      'ArabicDayName': arabicDayName,
      'HijriDate': hijriDate.convertToString(),
    };
  }
}
