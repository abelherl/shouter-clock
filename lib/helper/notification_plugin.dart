import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'dart:io' show File, Platform;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPlugin {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final didReceivedLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  void init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      _requestIOSPermission();
    }

    initializePlatformSpecifics();
  }

  void initializePlatformSpecifics() {
    var initializationSettingsAndroid = AndroidInitializationSettings('ic_notif');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(id: id, title: title, body: body, payload: payload);

        didReceivedLocalNotificationSubject.add(receivedNotification);
      }
    );

    initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  }

  void setListenerForLowerVersion(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject
        .listen((event) {
          onNotificationInLowerVersions(event);
    });
  }

  void setOnNotificationClicked(Function onNotificationClicked) async {
    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings, onSelectNotification: (String payload) {
          onNotificationClicked(payload);
    });
  }

  void _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
      alert: false,
      badge: true,
      sound: true,
    );
  }

  Future<void> disableNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showNotification({@required bool enabled, @required bool amPm, @required bool importanceHigh, String disabledHours}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (enabled) {
      for (int i = 0; i < 25; i++) {
        print("I = $i");
        DateTime time = DateTime.now();
        time = DateTime(
            time.year,
            time.month,
            i >= time.hour ? time.day + 1 : time.day,
            i,
            0,
            0,
            time.millisecond,
            time.microsecond,
        );
        String dateTime = DateFormat.jm().format(time).toString();

        if (dateTime.length < 8) {
          dateTime = "0$dateTime";
        }

        final amPmString = amPm ? dateTime[6] + dateTime[7] : '';

        dateTime = dateTime[0] + dateTime[1] + " o'clock " + amPmString;

        var androidChannelSpecifics = AndroidNotificationDetails(
          '${i}_${time.minute}_${amPm}_$importanceHigh',
          'SHOUTER_CLOCK',
          'SHOUTER_CLOCK',
          timeoutAfter: 5000,
          importance: importanceHigh ? Importance.max : Importance
              .defaultImportance,
          priority: importanceHigh ? Priority.max : Priority.defaultPriority,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notif2_mp3'),
        );
        var iosChannelSpecifics = IOSNotificationDetails(
          sound: 'notif2.aiff',
        );
        var platformChannelSpecifics = NotificationDetails(
            android: androidChannelSpecifics, iOS: iosChannelSpecifics);

        if (dateTime[0] == "0") {
          print("FINAL: $dateTime $i");
          dateTime = dateTime.replaceRange(0, 1, '');
          print("FINAL: $dateTime");
        }

        const platform = const MethodChannel('helper');

        tz.initializeTimeZones();
        final String timeZoneName = 'Asia/Bangkok';
        tz.setLocalLocation(tz.getLocation(timeZoneName));

        print("LOCATION: ${tz.local} ${tz.getLocation(timeZoneName)}");

        final tzTime = tz.TZDateTime.from(time, tz.getLocation(timeZoneName));

        // await flutterLocalNotificationsPlugin.periodicallyShow(i, "Shouter Clock", "It's $dateTime", RepeatInterval.everyMinute, platformChannelSpecifics);

        await flutterLocalNotificationsPlugin.showDailyAtTime(
            i,
            'Shouter Clock',
            "It's $dateTime",
            Time(time.hour, time.minute, time.second),
            platformChannelSpecifics,
            payload: "Test",
        );
      }
    }
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}