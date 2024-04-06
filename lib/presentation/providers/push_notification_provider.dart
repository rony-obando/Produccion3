import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontendapp/main.dart';
import 'package:frontendapp/presentation/widgets/Corrective_maintenance.dart';





// ignore: camel_case_types
class pushNotificationProvider {

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;



   Future<void> initNotifications() async { 
   
    initPushNotifications();
    initLocalNOtifications();
  }

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
    );
  final _localNOtification = FlutterLocalNotificationsPlugin(); 

  void handleMessage(RemoteMessage? message){
    if(message == null) return;
    navigatorKey.currentState?.pushNamed(
      route,
      arguments: message,
    );
  }

  Future initLocalNOtifications() async{
    const android = AndroidInitializationSettings('logouni12');
    const settings = InitializationSettings(
      android: android
    );
    await _localNOtification.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));
        handleMessage(message);
      }
    );

    final platform = _localNOtification.resolvePlatformSpecificImplementation<
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

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;

      _localNOtification.show(
        notification.hashCode, 
        notification.title, 
        notification.body, 
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: 'logouni12', 
            )
        ),
        payload: jsonEncode(message.toMap())
        );

    });
  }



}

Future<void> handleBackgroundMessage(RemoteMessage message) async{
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }





