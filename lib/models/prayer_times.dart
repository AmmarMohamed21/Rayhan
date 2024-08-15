class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  final DateTime date;
  final String arabicDate;
  final DateTime locationTimestamp;
  final String city;
  final String arabicDayName;

  final double latitude;
  final double longitude;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.arabicDate,
    required this.city,
    required this.locationTimestamp,
    required this.arabicDayName,
    required this.date,
    required this.latitude,
    required this.longitude,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      arabicDate: json["ArabicDate"] ?? "",
      city: json["City"] ?? "",
      arabicDayName: json["ArabicDayName"] ?? "",
      locationTimestamp:
          DateTime.tryParse(json["LocationTimestamp"]) ?? DateTime.now(),
      date: DateTime.tryParse(json["Date"]) ?? DateTime.now(),
      latitude: json["Latitude"],
      longitude: json["Longitude"],
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
      'LocationTimestamp': locationTimestamp.toIso8601String(),
      'City': city,
      'ArabicDayName': arabicDayName,
      'ArabicDate': arabicDate,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }
}
