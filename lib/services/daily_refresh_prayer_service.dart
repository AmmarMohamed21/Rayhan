import 'package:geolocator/geolocator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rayhan/services/crashlytics_service.dart';
import 'package:rayhan/services/prayer_times_service.dart';

import '../models/prayer_times.dart';
import 'local_storage.dart';

class DailyRefreshPrayerService {
  static Future<void> refreshPrayerTimes() async {
    try {
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
        PrayerTimes? cachedPrayerTimes =
            await LocalStorage.getCachedPrayerTimes();
        if (cachedPrayerTimes != null) {
          latitude = cachedPrayerTimes.latitude;
          longitude = cachedPrayerTimes.longitude;
          locationTimestamp = cachedPrayerTimes.locationTimestamp;
        }
      }

      if (latitude != null && longitude != null && locationTimestamp != null) {
        PrayerTimes? prayerTimes = await PrayerTimesService.getPrayerTimes(
            latitude, longitude, locationTimestamp);
        if (prayerTimes != null) {
          await LocalStorage.cachePrayerTimes(prayerTimes);

          await Future.wait([
            HomeWidget.saveWidgetData<String>('fajr', prayerTimes.fajr),
            HomeWidget.saveWidgetData<String>('sunrise', prayerTimes.sunrise),
            HomeWidget.saveWidgetData<String>('dhuhr', prayerTimes.dhuhr),
            HomeWidget.saveWidgetData<String>('asr', prayerTimes.asr),
            HomeWidget.saveWidgetData<String>('maghrib', prayerTimes.maghrib),
            HomeWidget.saveWidgetData<String>('isha', prayerTimes.isha),
            HomeWidget.saveWidgetData<String>('subtitle',
                "${prayerTimes.arabicDayName}، ${prayerTimes.arabicDate}\n${prayerTimes.city}")
          ]);

          HomeWidget.updateWidget(androidName: 'PrayerTimesWidget');
          HomeWidget.updateWidget(androidName: 'PrayerTimesSecondWidget');
          HomeWidget.updateWidget(androidName: 'PrayerTimesDarkWidget');
          HomeWidget.updateWidget(androidName: 'PrayerTimesSecondDarkWidget');
        }
      }
    } catch (e, st) {
      CrashlyticsService.sendReport(e.toString(), st, true);
    }
  }
}
