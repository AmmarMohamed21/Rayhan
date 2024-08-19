import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:location/location.dart';
import 'package:rayhan/models/prayer_times.dart';
import 'package:rayhan/services/local_storage.dart';
import 'package:rayhan/services/prayer_times_service.dart';
import 'package:rayhan/utilities/helper.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';

class PrayerTimesProvider extends ChangeNotifier {
  PrayerTimes? prayerTimes;

  bool isPermissionDenied = false;
  bool isLocationServiceDisabled = false;
  bool isPermissionDeniedForever = false;
  bool isNoInternet = false;

  Future<void> loadPrayerTimes({bool isRefreshing = false}) async {
    if (!isRefreshing &&
        prayerTimes != null &&
        prayerTimes!.locationTimestamp
                .difference(DateTime.now())
                .abs()
                .inMinutes <=
            15 &&
        prayerTimes!.date.isSameDate(DateTime.now())) {
      // The location is not older than 15 minutes and the date is the same
      return;
    }

    isNoInternet = !(await isInternet());
    bool locationServicesIssue = false;
    LocationPermission? permission;
    Position? position;
    PrayerTimes? cachedPrayerTimes;
    PrayerTimes? retrievedPrayerTimes;

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
          cachedPrayerTimes.date.isSameDate(DateTime.now())) {
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
      // await HomeWidget.saveWidgetData<Map<String, dynamic>>('prayerTimes', prayerTimes!.toJson());
      await Future.wait([
        HomeWidget.saveWidgetData<String>('fajr', prayerTimes!.fajr),
        HomeWidget.saveWidgetData<String>('sunrise', prayerTimes!.sunrise),
        HomeWidget.saveWidgetData<String>('dhuhr', prayerTimes!.dhuhr),
        HomeWidget.saveWidgetData<String>('asr', prayerTimes!.asr),
        HomeWidget.saveWidgetData<String>('maghrib', prayerTimes!.maghrib),
        HomeWidget.saveWidgetData<String>('isha', prayerTimes!.isha),
        HomeWidget.saveWidgetData<String>('subtitle',
            "${prayerTimes!.arabicDayName}، ${prayerTimes!.arabicDate}\n${prayerTimes!.city}")
      ]);

      HomeWidget.updateWidget(androidName: 'PrayerTimesWidget');
      HomeWidget.updateWidget(androidName: 'PrayerTimesSecondWidget');
      HomeWidget.updateWidget(androidName: 'PrayerTimesDarkWidget');
      HomeWidget.updateWidget(androidName: 'PrayerTimesSecondDarkWidget');
    }
    notifyListeners();
  }
}
