import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class IconLabelTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Widget endWidget;

  IconLabelTile({this.label, this.icon, this.iconColor, this.endWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0 * sizeRatio,
        left: 20.0 * sizeRatio,
        right: 20.0 * sizeRatio,
        bottom: 10.0 * sizeRatio,
      ),
      child: Container(
        height: 45.0 * sizeRatio,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 45.0 * sizeRatio,
            ),
            SizedBox(
              width: 17.0 * sizeRatio,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 25.0 * sizeRatio,
                color: Provider.of<Settings>(context).isNightTheme
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Spacer(),
            endWidget,
          ],
        ),
      ),
    );
  }
}
