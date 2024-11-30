import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print('token $fcmToken');
  }

  // final androidChannel = const AndroidNotificationChannel(
  //     'high_importance_channel', 'High_Importance_Notifications',
  //     description: 'This channel is used for important Notification',
  //     importance: Importance.defaultImportance);

  // final localNotifications = FlutterLocalNotificationsPlugin();

  // Future initPushNotifications() async {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //           alert: true, badge: true, sound: true);
  //   FirebaseMessaging.onMessage.listen((message) {
  //     final notification = message.notification;

  //     if (notification == null) return;

  //     localNotifications.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //             android: AndroidNotificationDetails(
  //                 androidChannel.id, androidChannel.name,
  //                 channelDescription: androidChannel.description,
  //                 icon: 'assets/icon.png')),
  //         payload: jsonEncode(message.toMap()));
  //   });
  // }

  // Future initLocalNotifications() async {
  //   const android = AndroidInitializationSettings('assets/icon.png');
  //   const settings = InitializationSettings(android: android);
  //   await localNotifications.initialize(settings);

  //   final platform = localNotifications.resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>();
  // }
}
