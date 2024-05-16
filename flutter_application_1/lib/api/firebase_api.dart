
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/main.dart';

class FirebaseAPi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  //initialize notifications
  Future<void> initNotification () async {
    _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print('Token: $fcmToken');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/profile_screen',
    );
  }

  Future initPushNotifications() async {
    //handle notif if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listeners for when a notif opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}