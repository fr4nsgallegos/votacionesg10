import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static initMessaging() async {
    String token = await firebaseMessaging.getToken() ?? '-';
    print(token);
    FirebaseMessaging.onMessage.listen(_onMessage);
  }

  //DETECTAR NOTIFICACIÓN CUANDO EL APP ESTA ABIERTO
  static _onMessage(RemoteMessage message) {
    if (message.notification != null) {
      print("*************************");
      print(message.notification);
      print(message.notification!.title);
      print(message.notification!.body);
      print("*************************");
    } else {
      print("asdasdasd");
    }
  }
}
