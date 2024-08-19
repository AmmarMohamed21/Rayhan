import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.icon,
    required this.message,
  });
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          SizedBox(
            height: 20 *
                Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 30 *
                  Provider.of<ThemeProvider>(context, listen: false).sizeRatio,
            ),
          ),
        ],
      ),
    );
  }
}
