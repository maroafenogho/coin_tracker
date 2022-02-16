import 'package:coin_tracker/screens/home.dart';
import 'package:coin_tracker/tools/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  final apiController = Get.put(ApiController());
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
            onSelectNotification: selectNotification)
        .then((value) => print('object'));
  }

  Future selectNotification(String? payload) async {
    await Get.to(() => HomeScreen());
  }

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          playSound: true,
          priority: Priority.high,
          ticker: 'ticker');

  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Coin Alert',
      'BTC price is ${apiController.btcPrice} and Eth price is ${apiController.ethPrice}',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}
