import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/settings_components/two_coloured_circle.dart';
import 'package:rayhan/providers/theme_provider.dart';
import 'package:rayhan/utilities/constants.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<ThemeProvider>(context).currentThemeName ==
                    'lightGreen'
                ? 22.0 *
                    Provider.of<ThemeProvider>(context, listen: false).sizeRatio
                : 20.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
            backgroundColor:
                Provider.of<ThemeProvider>(context).currentThemeName ==
                        'lightGreen'
                    ? kSecondaryColor
                    : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kGreenPrimaryColor,
              lowerColor: kLightBackgroundColor,
              diameter: Provider.of<ThemeProvider>(context).currentThemeName ==
                      'lightGreen'
                  ? 38.0 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio
                  : 36.0 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio,
            ),
          ),
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme('lightGreen');
          },
        ),
        SizedBox(
          width: 5.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<ThemeProvider>(context).currentThemeName ==
                    'lightBlue'
                ? 22.0 *
                    Provider.of<ThemeProvider>(context, listen: false).sizeRatio
                : 20.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
            backgroundColor:
                Provider.of<ThemeProvider>(context).currentThemeName ==
                        'lightBlue'
                    ? kSecondaryColor
                    : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kBluePrimaryColor,
              lowerColor: kLightBackgroundColor,
              diameter: Provider.of<ThemeProvider>(context).currentThemeName ==
                      'lightBlue'
                  ? 38.0 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio
                  : 36.0 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio,
            ),
          ),
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme('lightBlue');
          },
        ),
        SizedBox(
          width: 5.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<ThemeProvider>(context).currentThemeName ==
                    'darkGreen'
                ? 22.0 *
                    Provider.of<ThemeProvider>(context, listen: false).sizeRatio
                : 20.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
            backgroundColor:
                Provider.of<ThemeProvider>(context).currentThemeName ==
                        'darkGreen'
                    ? kSecondaryColor
                    : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kGreenPrimaryColor,
              lowerColor: const Color.fromRGBO(40, 40, 40, 1),
              diameter: Provider.of<ThemeProvider>(context).currentThemeName ==
                      'darkGreen'
                  ? 38.0 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio
                  : 36.0 *
                      Provider.of<ThemeProvider>(context, listen: false)
                          .sizeRatio,
            ),
          ),
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme('darkGreen');
          },
        ),
      ],
    );
  }
}
