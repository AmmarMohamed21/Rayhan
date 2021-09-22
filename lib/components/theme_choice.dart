import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/two_coloured_circle.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/services/settings.dart';

class ThemeChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<Settings>(context).isGreenTheme &&
                    !Provider.of<Settings>(context).isNightTheme
                ? 22.0 * sizeRatio
                : 20.0 * sizeRatio,
            backgroundColor: Provider.of<Settings>(context).isGreenTheme &&
                    !Provider.of<Settings>(context).isNightTheme
                ? kSecondaryColor
                : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kGreenLightPrimaryColor,
              lowerColor: kLightBackgroundColor,
              diameter: Provider.of<Settings>(context).isGreenTheme &&
                      !Provider.of<Settings>(context).isNightTheme
                  ? 38.0 * sizeRatio
                  : 36.0 * sizeRatio,
            ),
          ),
          onTap: () {
            Provider.of<Settings>(context, listen: false).setGreenTheme();
          },
        ),
        SizedBox(
          width: 5.0 * sizeRatio,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: !Provider.of<Settings>(context).isGreenTheme
                ? 22.0 * sizeRatio
                : 20.0 * sizeRatio,
            backgroundColor: !Provider.of<Settings>(context).isGreenTheme
                ? kSecondaryColor
                : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kBlueLightPrimaryColor,
              lowerColor: kLightBackgroundColor,
              diameter: !Provider.of<Settings>(context).isGreenTheme
                  ? 38.0 * sizeRatio
                  : 36.0 * sizeRatio,
            ),
          ),
          onTap: () {
            Provider.of<Settings>(context, listen: false).setBlueTheme();
          },
        ),
        SizedBox(
          width: 5.0 * sizeRatio,
        ),
        GestureDetector(
          child: CircleAvatar(
            radius: Provider.of<Settings>(context).isNightTheme
                ? 22.0 * sizeRatio
                : 20.0 * sizeRatio,
            backgroundColor: Provider.of<Settings>(context).isNightTheme
                ? kSecondaryColor
                : Colors.grey,
            child: TwoColouredCircle(
              upperColor: kGreenLightPrimaryColor,
              lowerColor: Color.fromRGBO(40, 40, 40, 1),
              diameter: Provider.of<Settings>(context).isNightTheme
                  ? 38.0 * sizeRatio
                  : 36.0 * sizeRatio,
            ),
          ),
          onTap: () {
            Provider.of<Settings>(context, listen: false).setNightTheme();
          },
        ),
      ],
    );
  }
}
