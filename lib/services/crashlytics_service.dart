///{@category Services}
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

///Responsible for sending reports to Firebase Crashlytics
class CrashlyticsService {
  // ///Used to define the user for reports sent to Firebase Crashlytics
  // static void setUserId(User user) {
  //   FirebaseCrashlytics.instance.setUserIdentifier(user.id);
  //   setKey("companyId", user.companyId);
  // }

  ///To record any logs needed before a crash or a report
  static void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  ///To send a report to Firebase Crashlytics
  ///[fatal] default is false, it is sent as true if the app crashes or a critical report needs to be uploaded quicker
  static Future<void> sendReport(
    String error,
    StackTrace? stacktrace, [
    bool fatal = false,
    String? reason,
    List<String> furtherInfo = const [],
  ]) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stacktrace,
      reason: reason,
      information: furtherInfo,
      printDetails: true,
      fatal: fatal,
    );
  }

  ///To set a key-value pair to be sent with the report
  static void setKey(String key, Object? value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value ?? 'null');
  }
}
