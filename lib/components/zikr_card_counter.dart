import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

import '../providers/theme_provider.dart';

class ZikrCardCounter extends StatelessWidget {
  const ZikrCardCounter({
    super.key,
    required this.number,
  });

  final int number;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 45.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          height: 45.0 *
              Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? kDarkBackgroundColor
                : const Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.circular(45.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor,
                offset: const Offset(0.0, 1.0),
                blurRadius: 3.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
              ),
            ],
          ),
          child: Center(
            child: Text(
              getArabicNumber(number),
              style: TextStyle(
                fontSize: 30.0 *
                    Provider.of<ThemeProvider>(context, listen: false)
                        .sizeRatio,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
