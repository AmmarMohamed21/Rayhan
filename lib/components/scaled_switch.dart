import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/services/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:rayhan/utilities/constants.dart';

class ScaledSwitch extends StatelessWidget {
  ScaledSwitch({this.isActive, this.onChanged});
  bool isActive;
  Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: Alignment.centerLeft,
      scale: 0.7 * heightRatio,
      child: CupertinoSwitch(
        value: isActive,
        activeColor: kSecondaryColor,
        onChanged: onChanged,
      ),
    );
  }
}
