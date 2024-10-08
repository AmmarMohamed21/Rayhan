import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/azkar_provider.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/providers/theme_provider.dart';
import 'package:rayhan/utilities/constants.dart';

import '../services/notifications_service.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ThemeProvider>(context, listen: false)
          .initTheme(context);
      await Provider.of<AzkarProvider>(context, listen: false).loadAzkarList();
      await Provider.of<SettingsProvider>(context, listen: false)
          .initializeSettings(context);
      if (!Provider.of<SettingsProvider>(context, listen: false).firstTime!) {
        NotificationsService.initializeFirebaseNotifications(false);
      }
      Provider.of<AzkarProvider>(context, listen: false).checkDatabaseUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? kDarkBackgroundColor
              : kLightBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SpinKitPulse(
              color: kGreenDarkColor,
              size: MediaQuery.of(context).size.width * 0.41,
            ),
          ),
          Image.asset(
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? 'assets/icon/logodark.png'
                : 'assets/icon/logo.png',
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
          ),
        ],
      ),
    );
  }
}
