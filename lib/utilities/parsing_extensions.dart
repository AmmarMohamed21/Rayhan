import 'package:flutter/material.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

extension ParsingString on String {
  ///This method used to parse date in both dd-mm-yyyy and yyyy-mm-dd formats into DateTime
  DateTime toDateTime() {
    String date = this;
    List<String> dateSplit = date.split('-'); //[yyyy, mm, dd] or [dd, mm, yyyy]
    if (dateSplit[0].length != 4) //If second case reverse
    {
      date = dateSplit.reversed.toList().join('-'); //'yyyy-mm-dd'
    }
    return DateTime.parse(date);
  }
}

extension DateOnlyCompare on DateTime {
  ///Compares the dates of two DateTime objects to check same day
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension MonthCompare on DateTime {
  ///Compares the months of two DateTime objects to check same month
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}

extension GetTimeOfDay on String {
  //Get Time of day from string in arabic format hh:mm
  TimeOfDay toTimeOfDay() {
    List<String> timeSplit = this.split(':');
    int hour = reverseArabicNumbers[timeSplit[0][0]]! * 10 +
        reverseArabicNumbers[timeSplit[0][1]]!;
    int minute = reverseArabicNumbers[timeSplit[1][0]]! * 10 +
        reverseArabicNumbers[timeSplit[1][1]]!;
    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension ParsingDate on DateTime {
  ///Converts DateTime to 'dd-mm-yyyy' instead of the normal toString() method
  String convertToString() {
    DateTime date = this;
    String convertedDate = date.toString(); //yyyy-mm-dd hh:mm:ss.mmm
    convertedDate = convertedDate.split(' ')[0]; //yyyy-mm-dd
    convertedDate =
        convertedDate.split('-').reversed.toList().join('-'); //dd-mm-yyyy
    return convertedDate;
  }
}

extension HijriDate on DateTime {
  String convertToHijriFormat() {
    DateTime date = this;
    String day = getArabicNumber(date.day);
    String month = hijriMonths[date.month]!;
    String year = getArabicNumber(date.year);
    return '$day $month $year';
  }
}
