import 'package:rayhan/models/zikr.dart';

class AzkarList {
  final int dbVersion;
  final List<Zikr> azkarSabah;
  final List<Zikr> azkarMasaa;
  final List<Zikr> azkarSalah;
  final List<Zikr> azkarNawm;
  final List<Zikr> azkarMotafreqa;

  AzkarList({
    required this.dbVersion,
    required this.azkarSabah,
    required this.azkarMasaa,
    required this.azkarSalah,
    required this.azkarNawm,
    required this.azkarMotafreqa,
  });

  factory AzkarList.fromJson(Map<String, dynamic> json) {
    return AzkarList(
      dbVersion: json['dbVersion'],
      azkarSabah:
          (json['azkarSabah'] as List).map((e) => Zikr.fromJson(e)).toList(),
      azkarMasaa:
          (json['azkarMasaa'] as List).map((e) => Zikr.fromJson(e)).toList(),
      azkarSalah:
          (json['azkarSalah'] as List).map((e) => Zikr.fromJson(e)).toList(),
      azkarNawm:
          (json['azkarNawm'] as List).map((e) => Zikr.fromJson(e)).toList(),
      azkarMotafreqa: (json['azkarMotafreqa'] as List)
          .map((e) => Zikr.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dbVersion': dbVersion,
      'azkarSabah': azkarSabah.map((e) => e.toJson()).toList(),
      'azkarMasaa': azkarMasaa.map((e) => e.toJson()).toList(),
      'azkarSalah': azkarSalah.map((e) => e.toJson()).toList(),
      'azkarNawm': azkarNawm.map((e) => e.toJson()).toList(),
      'azkarMotafreqa': azkarMotafreqa.map((e) => e.toJson()).toList(),
    };
  }
}
