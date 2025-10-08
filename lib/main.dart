import 'package:fcm_firebase_cloud_massaageing/firebase_options.dart';
import 'package:fcm_firebase_cloud_massaageing/screen/home_screen.dart';
import 'package:fcm_firebase_cloud_massaageing/utils/Notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
FirebaseMessaging.instance.subscribeToTopic("text");
  FirebaseMessaging.onMessage.listen((massage) {
    NotificationHelper.show(massage);
  });
  NotificationHelper.initialize();
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
      home: const HomeScreen()
    );
  }
}

