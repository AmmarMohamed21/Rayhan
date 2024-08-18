import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      FirebaseFirestore db = FirebaseFirestore.instance;
      final dbVersion = await db.collection('versions');
      QuerySnapshot querySnapshot = await dbVersion.get();
      List<Map<String, dynamic>> documents = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      int newDbVersion = documents[0]['dbVersion'];
      if (newDbVersion > azkarList!.dbVersion) {

        final sabahData = await db.collection('morning');
        QuerySnapshot querySnapshot = await sabahData.get();
        List<Map<String, dynamic>> documents = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        List<Zikr> azkarSabah =
          documents.map((zikr) => Zikr.fromJson(zikr)).toList();

        final masaaData = await db.collection('evening');
        querySnapshot = await masaaData.get();
        documents = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        List<Zikr> azkarMasaa =
          documents.map((zikr) => Zikr.fromJson(zikr)).toList();

        final salahData = await db.collection('prayer');
        querySnapshot = await salahData.get();
        documents = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        List<Zikr> azkarSalah =
          documents.map((zikr) => Zikr.fromJson(zikr)).toList();

        final nawmData = await db.collection('sleep');
        querySnapshot = await nawmData.get();
        documents = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        List<Zikr> azkarNawm =
          documents.map((zikr) => Zikr.fromJson(zikr)).toList();

        final motafreqaData = await db.collection('other');
        querySnapshot = await motafreqaData.get();
        documents = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        List<Zikr> azkarMotafreqa =
          documents.map((zikr) => Zikr.fromJson(zikr)).toList();

        azkarList = AzkarList(dbVersion: newDbVersion, azkarSabah: azkarSabah, azkarMasaa: azkarMasaa, azkarSalah: azkarSalah, azkarNawm: azkarNawm, azkarMotafreqa: azkarMotafreqa);
        await LocalStorage.saveAzkarList(azkarList!);
        notifyListeners();
      }
    }
  }
}
