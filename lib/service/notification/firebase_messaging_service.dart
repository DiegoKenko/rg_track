import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/local_notification.dart';
import 'package:rg_track/service/notification/local_notification_service.dart';

class FirebaseMessagingService {
  final LocalNotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    await getIt<FirebaseMessaging>()
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    _onMessage();
    _onMessageOpenedApp();
  }

  Future<String?> getDeviceFirebaseToken() async {
    return await getIt<FirebaseMessaging>().getToken();
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _notificationService.showLocalNotification(
          LocalNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {}
  }

  Future<void> sendMessage(String token) async {
    if (token.isEmpty) return;
    var x = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAXuQO9_0:APA91bEirrmvm8Z0QJl7nS2vgH6O_YbNCKHLFN_vyuv5IsNHCTU3A6l9k4KWl1y0JG_9W4IJ0G3LJbjVkphc8LbEiLOR42B8ruPYXyERjIINZdGTMELo1S1NnW5T4_yj1uOfZfhl0T_4',
      },
      body: jsonEncode({
        'to': token,
        'data': {
          'message': 'teste',
        },
        'notification': {
          'title': 'teste',
          'body': 'teste',
        },
        'content_available': true
      }),
    );
    debugPrint(x.toString());
  }
}
