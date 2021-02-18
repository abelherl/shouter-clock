import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shouter_clock/helper/notification_plugin.dart';
import 'package:shouter_clock/shared/constant_styling.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _clicked = false;
  SharedPreferences _sharedPreferences;
  final _settingsEnableNotifKey = "SETTINGS_ENABLE_NOTIF";

  @override
  void initState() {
    super.initState();
    notificationPlugin.setListenerForLowerVersion(() {});
    notificationPlugin.setOnNotificationClicked(() {});
    _init();
  }

  void _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.containsKey(_settingsEnableNotifKey)) {
      setState(() => _clicked = _sharedPreferences.getBool(_settingsEnableNotifKey));
    }
    else {
      _sharedPreferences.setBool(_settingsEnableNotifKey, false);
    }
  }

  void _onMainButtonClick() async {
    setState(() => _clicked = !_clicked);
    notificationPlugin.showNotification(enabled: true, amPm: false, importanceHigh: true);
    _sharedPreferences.setBool(_settingsEnableNotifKey, _clicked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Parent(
          gesture: Gestures()
            ..onTap(() => _onMainButtonClick()),
          style: ParentStyle()
            ..height(80)
            ..width(80)
            ..background.color(_clicked ? aGreen : aRed)
            ..borderRadius(all: 40),
        ),
      ),
    );
  }
}
