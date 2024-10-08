import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:location/location.dart';
import 'package:rayhan/services/local_storage.dart';
import 'package:rayhan/services/prayer_times_service.dart';
import 'package:rayhan/utilities/helper.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';

import '../models/monthly_prayer_times.dart';

class PrayerTimesProvider extends ChangeNotifier {
  MonthlyPrayerTimes? prayerTimes;

  bool isPermissionDenied = false;
  bool isLocationServiceDisabled = false;
  bool isPermissionDeniedForever = false;
  bool isNoInternet = false;

  bool isRefreshing = false;
  bool isLoading = false;

  Future<void> loadPrayerTimes(BuildContext context,
      {bool isRefreshing = false}) async {
    if (isLoading) {
      return;
    }
    if (!isRefreshing &&
        prayerTimes != null &&
        prayerTimes!.locationTimestamp
                .difference(DateTime.now())
                .abs()
                .inMinutes <=
            15 &&
        prayerTimes!.monthYear.isSameMonth(DateTime.now())) {
      // The location is not older than 15 minutes and the date is the same
      return;
    }

    this.isRefreshing = isRefreshing;
    isLoading = true;
    Future.delayed(Duration(milliseconds: 10), () => notifyListeners());

    isNoInternet = !(await isInternet());
    bool locationServicesIssue = false;
    LocationPermission? permission;
    Position? position;
    MonthlyPrayerTimes? cachedPrayerTimes;
    MonthlyPrayerTimes? retrievedPrayerTimes;

    if (!isNoInternet) //There is internet
    {
      //Check location service is on
      Location location = new Location();
      bool serviceEnabled = await location.requestService();

      //Check for location permissions
      if (!serviceEnabled) {
        isLocationServiceDisabled = true;
        isPermissionDenied = false;
        isPermissionDeniedForever = false;
        locationServicesIssue = true;
      } else {
        //location is on, so we check for permission
        permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.denied) {
          isPermissionDenied = true;
          isLocationServiceDisabled = false;
          isPermissionDeniedForever = false;
          locationServicesIssue = true;
        } //if denied forever
        if (permission == LocationPermission.deniedForever) {
          isPermissionDeniedForever = true;
          isPermissionDenied = false;
          isLocationServiceDisabled = false;
          locationServicesIssue = true;
        }
      }

      //if location is on and permission is granted we try to get the location
      if (!locationServicesIssue) {
        position = await PrayerTimesService.getCurrentLocation();
      }
      if (position == null &&
          (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse)) {
        //failed to get current location, we check last known
        position = await PrayerTimesService.getLastKnownPosition();
      }
      if (position != null) {
        retrievedPrayerTimes = await PrayerTimesService.getPrayerTimes(
            position.latitude, position.longitude, position.timestamp);
      } else //Failed to get any location so we use location of cached
      {
        cachedPrayerTimes =
            prayerTimes ?? await LocalStorage.getCachedPrayerTimes();
        if (cachedPrayerTimes != null) {
          retrievedPrayerTimes = await PrayerTimesService.getPrayerTimes(
              cachedPrayerTimes.latitude,
              cachedPrayerTimes.longitude,
              cachedPrayerTimes.locationTimestamp);
        }
      }
    }

    //if still we failed to get prayer times we try to get the cached prayer times
    if (retrievedPrayerTimes == null) {
      cachedPrayerTimes = prayerTimes ??
          cachedPrayerTimes ??
          await LocalStorage.getCachedPrayerTimes();

      //if same day we show it if we didn't get location or we got a location with a distance less than 10 km
      if (cachedPrayerTimes != null &&
          cachedPrayerTimes.monthYear.isSameMonth(DateTime.now())) {
        bool isDistanceBig = false;
        if (position != null) {
          double distanceInMeters = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              cachedPrayerTimes.latitude,
              cachedPrayerTimes.longitude);
          if (distanceInMeters > 10000) {
            isDistanceBig = true;
          }
        }
        if (!isDistanceBig) {
          retrievedPrayerTimes = cachedPrayerTimes;
        }
      }
    } else {
      //cache the prayer times
      prayerTimes = retrievedPrayerTimes;
      await LocalStorage.cachePrayerTimes(prayerTimes!);
    }

    //if still no prayer times and the permission is denied forever we open the app settings to allow the user to enable the location
    //TODO make it a button?
    if (prayerTimes == null && permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
    }

    if (prayerTimes != null) {
      int dayIndex = DateTime.now().day - 1;
      await Future.wait([
        HomeWidget.saveWidgetData<String>(
            'fajr', prayerTimes!.prayerTimes[dayIndex].fajr),
        HomeWidget.saveWidgetData<String>(
            'sunrise', prayerTimes!.prayerTimes[dayIndex].sunrise),
        HomeWidget.saveWidgetData<String>(
            'dhuhr', prayerTimes!.prayerTimes[dayIndex].dhuhr),
        HomeWidget.saveWidgetData<String>(
            'asr', prayerTimes!.prayerTimes[dayIndex].asr),
        HomeWidget.saveWidgetData<String>(
            'maghrib', prayerTimes!.prayerTimes[dayIndex].maghrib),
        HomeWidget.saveWidgetData<String>(
            'isha', prayerTimes!.prayerTimes[dayIndex].isha),
        HomeWidget.saveWidgetData<String>('subtitle',
            "${prayerTimes!.prayerTimes[dayIndex].arabicDayName}، ${prayerTimes!.prayerTimes[dayIndex].hijriDate.convertToHijriFormat()}\n${prayerTimes!.city}")
      ]);

      HomeWidget.updateWidget(androidName: 'PrayerTimesWidget');
      HomeWidget.updateWidget(androidName: 'PrayerTimesSecondWidget');
      HomeWidget.updateWidget(androidName: 'PrayerTimesDarkWidget');
      HomeWidget.updateWidget(androidName: 'PrayerTimesSecondDarkWidget');
    }

    this.isRefreshing = false;
    isLoading = false;
    notifyListeners();
  }
}
