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
