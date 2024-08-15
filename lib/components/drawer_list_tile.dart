import 'package:flutter/material.dart';
import 'package:rayhan/utilities/constants.dart';

class DrawerListTile extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final IconData icon;

  const DrawerListTile(
      {required this.onTap, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 4.0 * sizeRatio,
      minLeadingWidth: 40.0 * sizeRatio,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        size: 26.0 * sizeRatio,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 22.0 * sizeRatio,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
