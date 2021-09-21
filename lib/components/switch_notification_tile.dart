import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:rayhan/components/scaled_switch.dart';
import 'package:rayhan/services/settings.dart';
import 'package:rayhan/utilities/constants.dart';
import 'package:rayhan/utilities/helper.dart';

class SwitchNotificationTile extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSabah;
  bool isActive;

  SwitchNotificationTile(
      {this.label, this.icon, this.iconColor, this.isSabah, this.isActive});

  @override
  _SwitchNotificationTileState createState() => _SwitchNotificationTileState();
}

class _SwitchNotificationTileState extends State<SwitchNotificationTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: setNotification,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.0 * heightRatio,
          left: 20.0 * heightRatio,
          right: 20.0 * heightRatio,
          bottom: 10.0 * heightRatio,
        ),
        child: Container(
          constraints:
              BoxConstraints(minHeight: 45.0 * heightRatio * widthRatio),
          //height: 45.0 * heightRatio * widthRatio,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.iconColor,
                size: 45.0 * heightRatio * widthRatio,
              ),
              SizedBox(
                width: 17.0 * heightRatio * widthRatio,
              ),
              Column(
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 25.0 * heightRatio * widthRatio,
                      color: Provider.of<Settings>(context).isNightTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  widget.isActive
                      ? Text(
                          getSubtitle(widget.isSabah, context),
                          style: TextStyle(
                            fontSize: 20.0 * heightRatio * widthRatio,
                            color: Provider.of<Settings>(context).isNightTheme
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Spacer(),
              ScaledSwitch(
                isActive: widget.isActive,
                onChanged: boolCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void boolCallback(bool value) {
    setNotification();
  }

  void setNotification() async {
    int id;
    TimeOfDay initialTime;
    String notificationKey;
    String hoursKey;
    String minutesKey;
    if (widget.isSabah) {
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
    if (widget.isActive == false) {
      TimeOfDay timeofDay = await showRoundedTimePicker(
        context: context,
        positiveBtn: 'تأكيد',
        initialTime: initialTime,
        theme: ThemeData(
          dialogBackgroundColor:
              Provider.of<Settings>(context, listen: false).isNightTheme
                  ? kNightBackgroundColor
                  : kLightBackgroundColor,
          primarySwatch:
              Provider.of<Settings>(context, listen: false).isGreenTheme
                  ? kGreenMaterialPrimary
                  : kBlueMaterialPrimary,
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
      setState(() {
        widget.isActive = true;
      });
    } else {
      Provider.of<Settings>(context, listen: false).cancelNotification(id);
      setState(() {
        widget.isActive = false;
      });
    }
  }
}
