import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/settings_provider.dart';
import 'package:rayhan/utilities/constants.dart';

class ZikrCardTitle extends StatelessWidget {
  const ZikrCardTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0 * sizeRatio),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0 * sizeRatio),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              title,
              style: TextStyle(
                fontSize:
                    Provider.of<SettingsProvider>(context).isFontMed ?? false
                        ? 25 * sizeRatio
                        : 28 * sizeRatio,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
