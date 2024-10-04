import 'package:geolocator/geolocator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rayhan/models/monthly_prayer_times.dart';
import 'package:rayhan/services/crashlytics_service.dart';
import 'package:rayhan/services/prayer_times_service.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';

import 'hijri_date_service.dart';
import 'local_storage.dart';

class DailyRefreshPrayerService {
  static Future<void> refreshPrayerTimes() async {
    try {
      bool isGotPrayerFromApi = false;
      //get current saved cached prayer times
      MonthlyPrayerTimes? cachedPrayerTimes =
          await LocalStorage.getCachedPrayerTimes();

      MonthlyPrayerTimes? resultPrayerTimes;

      LocationPermission permission = await Geolocator.checkPermission();
      bool? isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      double? latitude;
      double? longitude;
      DateTime? locationTimestamp;
      if (isLocationServiceEnabled == true &&
          (permission == LocationPermission.always)) {
        //first try to get the current location
        Position? position = await PrayerTimesService.getCurrentLocation();
        if (position != null) {
          latitude = position.latitude;
          longitude = position.longitude;
          locationTimestamp = position.timestamp;
        }
      }
      if (latitude == null ||
          longitude == null ||
          locationTimestamp == null) //if failed try to get last known
      {
        Position? position = await PrayerTimesService.getLastKnownPosition();
        if (position != null) {
          latitude = position.latitude;
          longitude = position.longitude;
          locationTimestamp = position.timestamp;
        }
      } //if failed get it from last cached prayer times
      if (latitude == null || longitude == null || locationTimestamp == null) {
        if (cachedPrayerTimes != null) {
          latitude = cachedPrayerTimes.latitude;
          longitude = cachedPrayerTimes.longitude;
          locationTimestamp = cachedPrayerTimes.locationTimestamp;
        }
      }

      if (latitude != null && longitude != null && locationTimestamp != null) {
        if (cachedPrayerTimes != null) {
          bool isDistanceBig = false;
          double distanceInMeters = Geolocator.distanceBetween(
              latitude,
              longitude,
              cachedPrayerTimes.latitude,
              cachedPrayerTimes.longitude);
          if (distanceInMeters > 10000) {
            isDistanceBig = true;
          }
          if (cachedPrayerTimes.monthYear.isSameMonth(DateTime.now()) &&
              !isDistanceBig) {
            resultPrayerTimes = cachedPrayerTimes;
          }
        }
        if (resultPrayerTimes == null) {
          resultPrayerTimes = await PrayerTimesService.getPrayerTimes(
              latitude, longitude, locationTimestamp);
          isGotPrayerFromApi = resultPrayerTimes != null ? true : false;
        }
      }
      if (resultPrayerTimes == null &&
          cachedPrayerTimes != null &&
          cachedPrayerTimes.monthYear.isSameMonth(DateTime.now())) {
        resultPrayerTimes = cachedPrayerTimes;
      }

      //TODO correct hijri date if hijri day is 29/30/1/2
      if (!isGotPrayerFromApi && resultPrayerTimes != null) {
        if (resultPrayerTimes
                    .prayerTimes[DateTime.now().day - 1].hijriDate.day <
                3 ||
            resultPrayerTimes
                    .prayerTimes[DateTime.now().day - 1].hijriDate.day >
                28) {
          resultPrayerTimes =
              await HijriDateService.correctHijriDate(resultPrayerTimes);
        }
      }

      if (resultPrayerTimes != null) {
        int dayIndex = DateTime.now().day - 1;
        await LocalStorage.cachePrayerTimes(resultPrayerTimes);

        await Future.wait([
          HomeWidget.saveWidgetData<String>(
              'fajr', resultPrayerTimes.prayerTimes[dayIndex].fajr),
          HomeWidget.saveWidgetData<String>(
              'sunrise', resultPrayerTimes.prayerTimes[dayIndex].sunrise),
          HomeWidget.saveWidgetData<String>(
              'dhuhr', resultPrayerTimes.prayerTimes[dayIndex].dhuhr),
          HomeWidget.saveWidgetData<String>(
              'asr', resultPrayerTimes.prayerTimes[dayIndex].asr),
          HomeWidget.saveWidgetData<String>(
              'maghrib', resultPrayerTimes.prayerTimes[dayIndex].maghrib),
          HomeWidget.saveWidgetData<String>(
              'isha', resultPrayerTimes.prayerTimes[dayIndex].isha),
          HomeWidget.saveWidgetData<String>('subtitle',
              "${resultPrayerTimes.prayerTimes[dayIndex].arabicDayName}، ${resultPrayerTimes.prayerTimes[dayIndex].hijriDate.convertToHijriFormat()}\n${resultPrayerTimes.city}")
        ]);

        HomeWidget.updateWidget(androidName: 'PrayerTimesWidget');
        HomeWidget.updateWidget(androidName: 'PrayerTimesSecondWidget');
        HomeWidget.updateWidget(androidName: 'PrayerTimesDarkWidget');
        HomeWidget.updateWidget(androidName: 'PrayerTimesSecondDarkWidget');
      }
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
    }
  }
}
