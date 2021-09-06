import 'package:rayhan/constants.dart';

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
