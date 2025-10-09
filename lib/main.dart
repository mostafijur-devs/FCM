import 'package:fcm_firebase_cloud_massaageing/firebase_options.dart';
import 'package:fcm_firebase_cloud_massaageing/screen/home_screen.dart';
import 'package:fcm_firebase_cloud_massaageing/utils/Notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


Future<void> _onBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationHelper.show(message,);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase platform initialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase background message
  FirebaseMessaging.onBackgroundMessage(_onBackground);

  // firebase messaging permission
  FirebaseMessaging.instance.requestPermission();
  // create firebase topic
  FirebaseMessaging.instance.subscribeToTopic("text");

  // firebase massage send function


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}


