import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {

  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('logouni12');

  const DarwinInitializationSettings darwinInitializationSettings = 
  DarwinInitializationSettings();

  const InitializationSettings initializationSettings = 
  InitializationSettings(
    android: androidInitializationSettings,
    iOS: darwinInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

}

Future<void> printNotifications(String method, double result) async{
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('channelId', 'channelName',icon: 'logouni12');

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    
  );

  await flutterLocalNotificationsPlugin.show(
    1, 
    'Calculo registrado', 
    'se ha registrado el resultado $result del calculo $method', 
    notificationDetails,
    
    );
}