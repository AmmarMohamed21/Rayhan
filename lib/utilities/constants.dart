import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const Color kDarkBackgroundColor = Color(0xFF202020);
final Color kLightBackgroundColor = Colors.grey[50]!;

const Color kBlueDarkColor = Color(0xFF1d3557);
const Color kBluePrimaryColor = Color(0xFF457b9d);
const Color kBlueLightColor = Color(0xFFa8dadc);
const Color kBlueAccentColor = Color(0xFFf1faee);
const Color kSecondaryColor = Color(0xFFe63946);

const Color kGreenDarkColor = Color(0xFF1b4332);
const Color kGreenPrimaryColor = Color(0xFF40916c);
const Color kGreenLightColor = Color(0xFF74c69d);
const Color kGreenAccentColor = Color(0xFFf1faee);
// Color kGSecondaryColor = Color(0xFFe63946);

enum NotificationIDs { morningNotificationID, dawnNotificationID }

const Map arabicNumbers = {
  0: '٠',
  1: '١',
  2: '٢',
  3: '٣',
  4: '٤',
  5: '٥',
  6: '٦',
  7: '٧',
  8: '٨',
  9: '٩',
};

const Map<int, Color> kGreenPrimaryColorMap = {
  50: kGreenDarkColor,
  100: kGreenDarkColor,
  200: kGreenDarkColor,
  300: kGreenDarkColor,
  400: kGreenDarkColor,
  500: kGreenDarkColor,
  600: kGreenDarkColor,
  700: kGreenDarkColor,
  800: kGreenDarkColor,
  900: kGreenDarkColor,
};

const Map<int, Color> kBluePrimaryColorMap = {
  50: kBlueDarkColor,
  100: kBlueDarkColor,
  200: kBlueDarkColor,
  300: kBlueDarkColor,
  400: kBlueDarkColor,
  500: kBlueDarkColor,
  600: kBlueDarkColor,
  700: kBlueDarkColor,
  800: kBlueDarkColor,
  900: kBlueDarkColor,
};

const MaterialColor kBlueMaterialPrimary =
    MaterialColor(0xFF1d3557, kBluePrimaryColorMap);

const MaterialColor kGreenMaterialPrimary =
    MaterialColor(0xFF1b4332, kGreenPrimaryColorMap);

const String sabahNotifyTitle = 'أذكار الصباح';
const String masaaNotifyTitle = 'أذكار المساء';

const List<String> azkarMessageBody = [
  '(وَسَبِّحُوهُ بُكْرَةً وَأَصِيلًا)',
  '(وَاذْكُرْ رَبَّكَ فِي نَفْسِكَ تَضَرُّعاً وَخِيفَةً وَدُونَ الْجَهْرِ مِنْ الْقَوْلِ بِالْغُدُوِّ وَالآصَالِ وَلا تَكُنْ مِنْ الْغَافِلِين)َ',
  '(وَاذْكُر رَّبَّكَ كَثِيرًا وَسَبِّحْ بِالْعَشِيِّ وَالْإِبْكَارِ)',
  '(يَا أَيُّهَا الَّذِينَ آمَنُوا اذْكُرُوا اللَّهَ ذِكْراً كَثِيراً)',
  '(الَّذِينَ يَذْكُرُونَ اللَّهَ قِيَامًا وَقُعُودًا وَعَلَىٰ جُنُوبِهِمْ)',
  'قال رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ: "يقول الله تعالى : أنا عند ظن عبدي بي، و أنا معه إذا ذكرني، فان ذكرني في نفسه ذكرته في نفسي و ان ذكرني في ملأ ذكرته في ملأ خير منهم.."',
  'قال رَسُولُ اللَّهِ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ: "مثل الذي يذكر ربه و الذي لا يذكر ربه مثل الحي و الميت"',
];

const double kReferenceWidth = 392.7272;

const double kReferenceHeight = 791.6363;
