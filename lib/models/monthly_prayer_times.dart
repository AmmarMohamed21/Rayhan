import 'package:rayhan/models/prayer_times.dart';

class MonthlyPrayerTimes {
  final String city;
  final double latitude;
  final double longitude;
  final DateTime locationTimestamp;
  final DateTime monthYear;
  final List<PrayerTimes> prayerTimes;

  MonthlyPrayerTimes({
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.locationTimestamp,
    required this.monthYear,
    required this.prayerTimes,
  });

  factory MonthlyPrayerTimes.fromJson(Map<String, dynamic> json) {
    return MonthlyPrayerTimes(
      city: json['City'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      locationTimestamp:
          DateTime.tryParse(json['LocationTimestamp']) ?? DateTime.now(),
      monthYear: DateTime.parse(json['MonthYear']),
      prayerTimes: (json['PrayerTimes'] as List)
          .map((e) => PrayerTimes.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'City': city,
      'Latitude': latitude,
      'Longitude': longitude,
      'LocationTimestamp': locationTimestamp.toIso8601String(),
      'MonthYear': monthYear.toIso8601String(),
      'PrayerTimes': prayerTimes.map((e) => e.toJson()).toList(),
    };
  }

  MonthlyPrayerTimes copyWith({
    String? city,
    double? latitude,
    double? longitude,
    DateTime? locationTimestamp,
    DateTime? monthYear,
    List<PrayerTimes>? prayerTimes,
  }) {
    List<PrayerTimes> newPrayerTimes = [];
    if (prayerTimes != null) {
      newPrayerTimes = prayerTimes;
    } else {
      newPrayerTimes.addAll(this.prayerTimes);
    }
    return MonthlyPrayerTimes(
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationTimestamp: locationTimestamp ?? this.locationTimestamp,
      monthYear: monthYear ?? this.monthYear,
      prayerTimes: newPrayerTimes,
    );
  }
}
