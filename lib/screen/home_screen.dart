import 'package:fcm_firebase_cloud_massaageing/utils/Notification_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
