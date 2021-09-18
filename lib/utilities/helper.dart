import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String getArabicNumber(int num) {
  String arabicNum = '';
  arabicNum = arabicNumbers[num % 10];
  if (num >= 10) {
    arabicNum = arabicNumbers[num % 100 ~/ 10] + arabicNum;
  }
  if (num >= 100) {
    arabicNum = arabicNumbers[num % 1000 ~/ 100] + arabicNum;
  }
  return arabicNum;
}

String addZeroToSingleDigit(String number) {
  if (number.length == 1) {
    number = '٠' + number;
  }
  return number;
}

String getSubtitle(String title, BuildContext context) {
  int hours;
  int minutes;
  if (title == 'إشعارات أذكار الصباح') {
    hours = Provider.of<Settings>(context, listen: false).sabahHours;
    minutes = Provider.of<Settings>(context, listen: false).sabahMinutes;
  } else {
    hours = Provider.of<Settings>(context, listen: false).masaaHours;
    minutes = Provider.of<Settings>(context, listen: false).masaaMinutes;
  }
  return 'وقت الإشعار اليومي: ' +
      addZeroToSingleDigit(getArabicNumber(hours)) +
      ':' +
      addZeroToSingleDigit(getArabicNumber(minutes));
}
