class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  final DateTime date;
  final String arabicDate;
  final String arabicDayName;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.arabicDate,
    required this.arabicDayName,
    required this.date,
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
      arabicDayName: json["ArabicDayName"] ?? "",
      date: DateTime.tryParse(json["Date"]) ?? DateTime.now(),
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
      'ArabicDate': arabicDate,
    };
  }
}
