import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';

class DrawerListTile extends StatelessWidget {
  final Function onTap;
  final String label;
  final IconData icon;

  DrawerListTile({this.onTap, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 4.0 * sizeRatio,
      minLeadingWidth: 40.0 * sizeRatio,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Provider.of<Settings>(context, listen: false).isNightTheme
            ? Colors.white
            : Colors.black,
        size: 26.0 * sizeRatio,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 25.0 * sizeRatio,
          color: Provider.of<Settings>(context, listen: false).isNightTheme
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
