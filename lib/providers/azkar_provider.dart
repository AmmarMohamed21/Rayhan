import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rayhan/services/crashlytics_service.dart';

import '../models/azkar_list.dart';
import '../models/zikr.dart';
import '../services/local_storage.dart';
import '../utilities/helper.dart';

class AzkarProvider extends ChangeNotifier {
  AzkarList? azkarList;

  Future<void> loadAzkarList() async {
    if (azkarList != null) return;
    AzkarList? localAzkarList = await LocalStorage.getAzkarList();
    if (localAzkarList != null) {
      azkarList = localAzkarList;
    } else {
      String jsonString = await rootBundle.loadString('assets/initialDB.json');
      azkarList = AzkarList.fromJson(jsonDecode(jsonString));
      await LocalStorage.saveAzkarList(azkarList!);
    }
    notifyListeners();
  }

  Future<void> checkDatabaseUpdate() async {
    bool isInternetConnected = await isInternet();
    if (isInternetConnected) {
      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        final dbVersion = await db.collection('versions');
        QuerySnapshot querySnapshot = await dbVersion.get();
        List<Map<String, dynamic>> documents = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        int newDbVersion = documents[0]['version'];
        if (newDbVersion != azkarList!.dbVersion) {
          List<Zikr> azkarSabah = await _getListFromDatabase(db, 'morning');

          List<Zikr> azkarMasaa = await _getListFromDatabase(db, 'evening');

          List<Zikr> azkarSalah = await _getListFromDatabase(db, 'prayer');

          List<Zikr> azkarNawm = await _getListFromDatabase(db, 'sleep');

          List<Zikr> azkarMotafreqa = await _getListFromDatabase(db, 'other');

          azkarList = AzkarList(
              dbVersion: newDbVersion,
              azkarSabah: azkarSabah,
              azkarMasaa: azkarMasaa,
              azkarSalah: azkarSalah,
              azkarNawm: azkarNawm,
              azkarMotafreqa: azkarMotafreqa);
          await LocalStorage.saveAzkarList(azkarList!);
          notifyListeners();
        }
      } catch (e, st) {
        CrashlyticsService.sendReport(e.toString(), st, true);
      }
    }
  }

  Future<List<Zikr>> _getListFromDatabase(
      FirebaseFirestore db, String collectionName) async {
    final data =
        await db.collection(collectionName).orderBy(FieldPath.documentId);
    QuerySnapshot querySnapshot = await data.get();
    List<Map<String, dynamic>> documents = querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
    return documents.map((zikr) => Zikr.fromJson(zikr)).toList();
  }
}
