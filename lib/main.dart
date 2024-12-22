import 'package:appvotacionesg10/firebase_options.dart';
import 'package:appvotacionesg10/pages/home_page.dart';
import 'package:appvotacionesg10/pages/login_page.dart';
import 'package:appvotacionesg10/utils/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initMessaging();
  await NotificationService().suscribeToTopic("ganadores");
  runApp(
    MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
