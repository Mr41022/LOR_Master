import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Map<String, dynamic>? _pendingPayload;

  // Initialize notifications
  Future<NotificationSettings> initNotifications(BuildContext context) async {
    await Firebase.initializeApp();

    // Request notification permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: true,
      announcement: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted notification permission');

      // Local notifications setup
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          log("Local notification tapped: ${response.payload}");
          _handleNotificationTap(context, response.payload);
        },
      );

      // Set foreground notification presentation options to true
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Handle foreground FCM messages only when app is in use
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (WidgetsBinding.instance.lifecycleState ==
            AppLifecycleState.resumed) {
          _showNotification(message);
        }
      });

      // Handle background notification taps
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // log("Notification opened from background: ${message.data}");
        if (context.mounted) {
          _handleNotificationTap(context, message.data['payload']);
        }
      });

      // Handle terminated state notification taps
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          log("App opened from terminated state: ${message.data}");
          _pendingPayload = message.data;
        }
      });
    } else {
      log('User declined notifications permission');
    }
    return settings;
  }

  // Show local notification
  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'You have recieved a Notification',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: json.encode(message.data), // Ensure payload is stored
    );
  }

  // Handle notification taps
  void _handleNotificationTap(BuildContext context, String? payload) {
    if (payload != null) {
      log("on notification tap: $payload");
    }
  }

  // Call this in main.dart to check pending notifications
  void checkPendingNotificationTap(BuildContext context) {
    if (_pendingPayload != null) {
      _handleNotificationTap(context, _pendingPayload!['payload']);
      _pendingPayload = null;
    }
  }
}
