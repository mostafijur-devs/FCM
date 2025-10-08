import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
 static final notification = FlutterLocalNotificationsPlugin();

  static initialize() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    DarwinInitializationSettings iOS = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await notification.initialize(initializationSettings);

    if (Platform.isAndroid) {
      await notification
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      await notification
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestExactAlarmsPermission();
    } else {
      await notification
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions();
    }
  }

  static show (RemoteMessage massage)async{
    AndroidNotificationDetails androidNotificationDetails =AndroidNotificationDetails("channelId", "channelName");
    DarwinNotificationDetails iOS = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOS
    );

    await notification.show(100, 'Sample title', 'This is notification body', notificationDetails);
  }
}
