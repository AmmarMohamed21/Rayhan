import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:rayhan/constants.dart';
import 'package:rayhan/services/helper.dart';
import 'package:rayhan/services/settings.dart';

import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class NotificationSwitch extends StatefulWidget {
  NotificationSwitch({this.isActive, this.title, this.icon, this.iconColor});
  bool isActive;
  String title;
  IconData icon;
  Color iconColor;
  String subtitle;
  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SwitchListTile(
          value: widget.isActive,
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 25.0,
              color: Provider.of<Settings>(context).isNightTheme
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          subtitle: widget.isActive
              ? Text(
                  getSubtitle(widget.title),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Provider.of<Settings>(context).isNightTheme
                        ? Colors.white70
                        : Colors.black54,
                  ),
                )
              : null,
          activeColor: kSecondaryColor,
          onChanged: (bool value) async {
            int id;
            TimeOfDay initialTime;
            String notificationKey;
            String hoursKey;
            String minutesKey;
            if (widget.title == 'إشعارات أذكار الصباح') {
              id = notificationsIDs.sabahNotificationID.index;
              initialTime = TimeOfDay(hour: 3, minute: 0);
              notificationKey = 'isSabahActive';
              hoursKey = 'sabahHours';
              minutesKey = 'sabahMinutes';
            } else {
              id = notificationsIDs.masaaNotificationID.index;
              initialTime = TimeOfDay(hour: 16, minute: 0);
              notificationKey = 'isMasaaActive';
              hoursKey = 'masaaHours';
              minutesKey = 'masaaMinutes';
            }
            if (value == true) {
              TimeOfDay timeofDay = await showRoundedTimePicker(
                context: context,
                positiveBtn: 'تأكيد',
                initialTime: initialTime,
                theme: ThemeData(
                  dialogBackgroundColor:
                      Provider.of<Settings>(context, listen: false).isNightTheme
                          ? Color(0xFF202020)
                          : Colors.grey[50],
                  primarySwatch:
                      Provider.of<Settings>(context, listen: false).isGreenTheme
                          ? kGreenMaterialPrimary
                          : kBlueMaterialPrimary, //hereeee
                ),
              );
              if (timeofDay == null) {
                setState(() {
                  widget.isActive = false;
                });
                return;
              }
              Provider.of<Settings>(context, listen: false)
                  .setNotification(id, timeofDay.hour, timeofDay.minute);
              Provider.of<Settings>(context, listen: false).setPreferences(
                  notificationKey,
                  hoursKey,
                  minutesKey,
                  timeofDay.hour,
                  timeofDay.minute);
            } else {
              Provider.of<Settings>(context, listen: false)
                  .cancelNotification(id);
            }

            //prefs.setBool(notificationKey, value);

            setState(() {
              widget.isActive = value;
            });
          },
          secondary: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: 45.0,
            ),
          ),
        ),
      ),
    );
  }

  String getSubtitle(String title) {
    int hours;
    int minutes;
    if (title == 'إشعارات أذكار الصباح') {
      hours = Provider.of<Settings>(context, listen: false).sabahHours;
      minutes = Provider.of<Settings>(context, listen: false).sabahMinutes;
    } else {
      hours = Provider.of<Settings>(context, listen: false).masaaHours;
      minutes = Provider.of<Settings>(context, listen: false).masaaMinutes;
    }
    return 'وقت الإشعار اليومي: ' +
        addZeroToSingleDigit(getArabicNumber(hours)) +
        ':' +
        addZeroToSingleDigit(getArabicNumber(minutes));
  }
}
