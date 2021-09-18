import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';

class DrawerListTile extends StatelessWidget {
  final Function onTap;
  final String label;
  final IconData icon;

  DrawerListTile({this.onTap, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Provider.of<Settings>(context, listen: false).isNightTheme
            ? Colors.white
            : Colors.black,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 25.0,
          color: Provider.of<Settings>(context, listen: false).isNightTheme
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
