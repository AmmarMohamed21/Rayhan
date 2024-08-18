import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/providers/settings_provider.dart';

import '../../providers/theme_provider.dart';

class ZikrCardContainer extends StatelessWidget {
  const ZikrCardContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(
          20 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.0 *
            Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            offset: const Offset(0.0, 1.0),
            blurRadius: 3.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0 *
            Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColorDark,
                fontSize:
                    Provider.of<SettingsProvider>(context).isFontMed ?? false
                        ? 22.0 *
                            Provider.of<ThemeProvider>(context, listen: false)
                                .sizeRatio
                        : 26.0 *
                            Provider.of<ThemeProvider>(context, listen: false)
                                .sizeRatio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
