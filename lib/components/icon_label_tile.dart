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
        top: 10.0 * heightRatio,
        left: 20.0 * heightRatio,
        right: 20.0 * heightRatio,
        bottom: 10.0 * heightRatio,
      ),
      child: Container(
        height: 45.0 * heightRatio * widthRatio,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 45.0 * heightRatio * widthRatio,
            ),
            SizedBox(
              width: 17.0 * heightRatio * widthRatio,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 25.0 * heightRatio * widthRatio,
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
