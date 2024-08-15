import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/providers/theme_provider.dart';
import 'package:rayhan/utilities/constants.dart';

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
    Provider.of<ThemeProvider>(context, listen: false)
        .initTheme(context)
        .then((_) {
      Provider.of<SettingsProvider>(context, listen: false)
          .initializeSettings(context);
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
