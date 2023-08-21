import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleMsg(RemoteMessage? msg) async {
  log('Notification Title: ${msg?.notification?.title}');
  log('Notification Body: ${msg?.notification?.body}');
  log('Notification Payload: ${msg?.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notification',
    description: 'This channel is for High Importance Notification',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.setAutoInitEnabled(true);
    final fcmToken = await _firebaseMessaging.getToken();
    log("FCMToken $fcmToken");
    initPushNotifications();
    initLocalNotifications();

    //FirebaseMessaging.onMessage.listen(handleMsg);
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(iOS: iOS, android: android,macOS: iOS);

    await _localNotifications.initialize(
      setting,
      onDidReceiveNotificationResponse: (details) async {
        //log('onDidReceiveNotificationResponse ${jsonDecode(details.payload??'')}');
        try {
          final messgae = RemoteMessage.fromMap(jsonDecode(details.payload.toString()));
          await handleMsg(messgae);
        } catch (e) {
          log('Error $e');
        }
      },
      onDidReceiveBackgroundNotificationResponse: (details) async{
        //log('onDidReceiveBackgroundNotificationResponse');
       try {
          final messgae = RemoteMessage.fromMap(jsonDecode(details.payload.toString()));
          await handleMsg(messgae);
        } catch (e) {
          log('Error $e');
        }
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMsg);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMsg);
    FirebaseMessaging.onBackgroundMessage(handleMsg);

    FirebaseMessaging.onMessage.listen((msg) {
      final notification = msg.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@drawable/ic_launcher',
        )),
        payload: jsonEncode(msg.toMap()),
      );
    });
  }
}
