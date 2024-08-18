import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/utilities/constants.dart';

import '../../providers/theme_provider.dart';

class ScaledSwitch extends StatelessWidget {
  const ScaledSwitch(
      {super.key, required this.isActive, required this.onChanged});
  final bool isActive;
  final void Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: Alignment.centerLeft,
      scale: 0.7 * Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
      child: CupertinoSwitch(
        value: isActive,
        activeColor: kSecondaryColor,
        onChanged: onChanged,
      ),
    );
  }
}
