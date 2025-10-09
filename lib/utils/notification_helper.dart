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

    // notification initialization create
    await notification.initialize(initializationSettings,);

    //device token call function
    getDeviceToken();


// android notification permission function condition
    if (Platform.isAndroid) {
      await notification
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      // await notification
      //     .resolvePlatformSpecificImplementation<
      //       AndroidFlutterLocalNotificationsPlugin
      //     >()
      //     ?.requestExactAlarmsPermission();
    }
    else {
      await notification
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions();
    }
  }

  // get token function
  static getDeviceToken() async {
   String? deviceToken = await FirebaseMessaging.instance.getToken();
   print(deviceToken);
  }
// refresh token function
  static refreshDeviceToken()async{

    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      event.toString();
      print('Refresh');
    },);

  }

//Notification show function
  static show(RemoteMessage massage) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName");
    DarwinNotificationDetails iOS = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOS,
    );

    await notification.show(
      massage.hashCode,
      massage.notification?.title,
      massage.notification?.body,
      notificationDetails,
    );
  }
}
