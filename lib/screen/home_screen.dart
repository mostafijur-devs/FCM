import 'package:fcm_firebase_cloud_massaageing/utils/Notification_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // NotificationHelper.getDeviceToken();

    NotificationHelper.firebaseInit(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),

      body: Center(
        child: ElevatedButton(onPressed: () {
          // NotificationHelper.show();
        }, child: Text('notification show')),
      ),
    );
  }
}
