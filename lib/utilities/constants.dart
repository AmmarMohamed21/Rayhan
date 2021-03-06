import 'package:flutter/material.dart';

const Color kNightBackgroundColor = Color(0xFF202020);
final Color kLightBackgroundColor = Colors.grey[50];

const Color kBluePrimaryColor = Color(0xFF1d3557);
const Color kBlueLightPrimaryColor = Color(0xFF457b9d);
const Color kBlueLightColor = Color(0xFFa8dadc);
const Color kBlueAccentColor = Color(0xFFf1faee);
const Color kSecondaryColor = Color(0xFFe63946);

const Color kGreenPrimaryColor = Color(0xFF1b4332);
const Color kGreenLightPrimaryColor = Color(0xFF40916c);
const Color kGreenLightColor = Color(0xFF74c69d);
const Color kGreenAccentColor = Color(0xFFf1faee);
// Color kGSecondaryColor = Color(0xFFe63946);

enum notificationsIDs { sabahNotificationID, masaaNotificationID }

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
  50: kGreenPrimaryColor,
  100: kGreenPrimaryColor,
  200: kGreenPrimaryColor,
  300: kGreenPrimaryColor,
  400: kGreenPrimaryColor,
  500: kGreenPrimaryColor,
  600: kGreenPrimaryColor,
  700: kGreenPrimaryColor,
  800: kGreenPrimaryColor,
  900: kGreenPrimaryColor,
};

const Map<int, Color> kBluePrimaryColorMap = {
  50: kBluePrimaryColor,
  100: kBluePrimaryColor,
  200: kBluePrimaryColor,
  300: kBluePrimaryColor,
  400: kBluePrimaryColor,
  500: kBluePrimaryColor,
  600: kBluePrimaryColor,
  700: kBluePrimaryColor,
  800: kBluePrimaryColor,
  900: kBluePrimaryColor,
};

const MaterialColor kBlueMaterialPrimary =
    MaterialColor(0xFF1d3557, kBluePrimaryColorMap);

const MaterialColor kGreenMaterialPrimary =
    MaterialColor(0xFF1b4332, kGreenPrimaryColorMap);

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

double sizeRatio;
