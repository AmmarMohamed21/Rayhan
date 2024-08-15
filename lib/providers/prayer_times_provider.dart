import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:rayhan/models/prayer_times.dart';
import 'package:rayhan/services/local_storage.dart';
import 'package:rayhan/services/prayer_times_service.dart';
import 'package:rayhan/utilities/parsing_extensions.dart';

class PrayerTimesProvider extends ChangeNotifier {
  PrayerTimes? prayerTimes;

  bool isPermissionDenied = false;
  bool isLocationServiceDisabled = false;
  bool isPermissionDeniedForever = false;
  bool isNoInternet = false;

  Future<void> loadPrayerTimes({bool isRefreshing = false}) async {
    //First return the prayer times if it already loaded with location timestamp not older than 5 minutes
    if (!isRefreshing &&
        prayerTimes != null &&
        prayerTimes!.locationTimestamp
                .difference(DateTime.now())
                .abs()
                .inMinutes <=
            5 &&
        prayerTimes!.date.isSameDate(DateTime.now())) {
      // The location is not older than 5 minutes and the date is the same
      return;
    }

    //Try to get the current location
    Location location = new Location();
    bool serviceEnabled =
        await location.requestService(); //request to enable location service

    LocationPermission? permission;

    bool locationServicesIssue = false;
    if (!serviceEnabled) {
      isLocationServiceDisabled = true;
      isPermissionDenied = false;
      isPermissionDeniedForever = false;
      locationServicesIssue = true;
    } else {
      //location is on, so we check for permission
      permission = await Geolocator.requestPermission();
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
    Position? position;
    if (!locationServicesIssue) {
      position = await PrayerTimesService.getCurrentLocation();
      if (position != null) {
        //if we get the location we get the prayer times
        bool isInternet = await PrayerTimesService.isInternet();
        if (isInternet) {
          prayerTimes = await PrayerTimesService.getPrayerTimes(position);
        } else {
          isNoInternet = true;
        }
      }
    }

    //if still we failed to get prayer times we try to get the cached prayer times
    if (prayerTimes == null) {
      PrayerTimes? cachedPrayerTimes =
          await LocalStorage.getCachedPrayerTimes();

      //if same day we show it if we didn't get location or we got a location with a distance less than 10 km
      if (cachedPrayerTimes != null &&
          cachedPrayerTimes.date.isSameDate(DateTime.now())) {
        bool isDistanceBig = false;
        if (position != null) {
          double distanceInMeters = Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              cachedPrayerTimes!.latitude,
              cachedPrayerTimes.longitude);
          if (distanceInMeters > 10000) {
            isDistanceBig = true;
          }
        }
        if (!isDistanceBig) {
          prayerTimes = cachedPrayerTimes;
        }
      }
    } else {
      //cache the prayer times
      LocalStorage.cachePrayerTimes(prayerTimes!);
    }

    //if still no prayer times and the permission is denied forever we open the app settings to allow the user to enable the location
    //TODO make it a button?
    if (prayerTimes == null && permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
    }
    notifyListeners();
  }
}