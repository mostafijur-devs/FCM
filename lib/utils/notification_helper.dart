import 'dart:io';
import 'package:fcm_firebase_cloud_massaageing/screen/secend_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final notification = FlutterLocalNotificationsPlugin();


 static firebaseInit (BuildContext context) async{
   FirebaseMessaging.onMessage.listen((massage) {
     localNotificationInitialize(context,massage);
     show(massage);
   });
   getDeviceToken();

  }

  static localNotificationInitialize(BuildContext context,RemoteMessage massage) async {

    AndroidInitializationSettings android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    DarwinInitializationSettings iOS = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    // notification initialization create
    await notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {

        Navigator.push(context, MaterialPageRoute(builder: (context) => SecendScreen(),));


        // _handelMessage();
      },
    );
    //device token call function


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
    } else {
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
  static refreshDeviceToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      event.toString();
      print('Refresh');
    });
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

