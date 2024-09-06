import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gate/firebase_options.dart';
import 'package:flutter_gate/notification/local_notification.dart';
import 'package:flutter_gate/ui/login/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gate/firebase_options.dart';
import 'package:flutter_gate/notification/local_notification.dart';
import 'package:flutter_gate/ui/home/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationData().initialNotification();
  await LocalNotificationData.initialize(flutterLocalNotificationsPlugin);

  // Get the stored login status from GetStorage
  final storage = GetStorage();
  bool isLoggedIn = storage.read<bool>('isLoggedIn') ?? false;

  runApp(
    MyApp(isLoggedIn: isLoggedIn),
  );
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Check the login status and decide which screen to show
      home: isLoggedIn ?   HomeScreen() :  LoginScreen(),
    );
  }
}

