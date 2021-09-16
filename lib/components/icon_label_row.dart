import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';

class IconLabelRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Widget endWidget;

  IconLabelRow({this.label, this.icon, this.iconColor, this.endWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0, left: 34.0, right: 23.0, bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 45.0,
          ),
          SizedBox(
            width: 17.0,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 25.0,
              color: Provider.of<Settings>(context).isNightTheme
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          Spacer(),
          endWidget,
        ],
      ),
    );
  }
}
