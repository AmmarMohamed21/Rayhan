import 'package:flutter/material.dart';

import '../models/zikr.dart';

class AzkarListProvider extends ChangeNotifier {
  List<Zikr> currentAzkar;
  int totalCounter = 0;
  bool isCounterDone = false;
  AzkarListProvider({required this.currentAzkar}) {
    for (Zikr zikr in currentAzkar) {
      totalCounter += zikr.count;
    }
  }

  void decrementCounter() {
    totalCounter--;
    if (totalCounter == 0) {
      isCounterDone = true;
    }
    notifyListeners();
  }
}
