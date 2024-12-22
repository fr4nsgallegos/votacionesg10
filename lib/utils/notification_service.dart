import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static initMessaging() async {
    String token = await firebaseMessaging.getToken() ?? '-';
    print(token);

    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onBackgroundMessage(_onBackGroundMessage);
  }

  //SUSCRIBIR A UN TOPIC
  Future<void> suscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
    print("Dispositivo suscrito al topic: $topic");
  }

  //CANCELAR LA SUSCRIPCIÓN AL TOPIC
  Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
    print("Dispositivo eliminado del topic $topic");
  }

  //DETECTAR NOTIFICACIÓN CUANDO EL APP ESTA ABIERTO
  static _onMessage(RemoteMessage message) {
    if (message.notification != null) {
      print("*************************");
      print(message.notification);
      print(message.notification!.title);
      print(message.notification!.body);
      print("*************************");
    }

    if (message.data.isNotEmpty) {
      print("*/*/*/*/*/*/*/*/**/*/*/*/*/*/");
      print("DATOS: ${message.data}");
      print(message.data["key1"]);
      print(message.data["key2"]);
      print("*/*/*/*/*/*/*/*/**/*/*/*/*/*/");
    }
  }

  static Future _onBackGroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("------------------------");
      print(message.notification!.title);
      print(message.notification!.body);
      print("------------------------");
    }
    if (message.data.isNotEmpty) {
      print("*/*/*/*/*/*/*/*/**/*/*/*/*/*/");
      print("DATOS: ${message.data}");
      print(message.data["key1"]);
      print(message.data["key2"]);
      print("*/*/*/*/*/*/*/*/**/*/*/*/*/*/");
    }
  }
}
