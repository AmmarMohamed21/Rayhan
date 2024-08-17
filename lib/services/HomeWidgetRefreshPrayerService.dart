import 'package:home_widget/home_widget.dart';
import 'package:rayhan/services/crashlytics_service.dart';
import 'package:rayhan/services/prayer_times_service.dart';

import '../models/prayer_times.dart';
import 'local_storage.dart';

class HomeWidgetRefreshPrayerService {
  static Future<void> refreshPrayerTimes() async {
    try {
      PrayerTimes? cachedPrayerTimes =
          await LocalStorage.getCachedPrayerTimes();
      if (cachedPrayerTimes != null) {
        PrayerTimes? prayerTimes = await PrayerTimesService.getPrayerTimes(
            cachedPrayerTimes.latitude,
            cachedPrayerTimes.longitude,
            cachedPrayerTimes.locationTimestamp);
        if (prayerTimes != null) {
          await LocalStorage.cachePrayerTimes(prayerTimes);

          await HomeWidget.saveWidgetData<String>('fajr', prayerTimes!.fajr);
          await HomeWidget.saveWidgetData<String>(
              'sunrise', prayerTimes!.sunrise);
          await HomeWidget.saveWidgetData<String>('dhuhr', prayerTimes!.dhuhr);
          await HomeWidget.saveWidgetData<String>('asr', prayerTimes!.asr);
          await HomeWidget.saveWidgetData<String>(
              'maghrib', prayerTimes!.maghrib);
          await HomeWidget.saveWidgetData<String>('isha', prayerTimes!.isha);
          await HomeWidget.saveWidgetData<String>('subtitle',
              "${prayerTimes!.arabicDayName}، ${prayerTimes!.arabicDate}\n${prayerTimes!.city}");

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
