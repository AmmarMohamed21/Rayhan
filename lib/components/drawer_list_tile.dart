import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';

class DrawerListTile extends StatelessWidget {
  final Function onTap;
  final String label;

  DrawerListTile({this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
