import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:coin_tracker/tools/api_service.dart';
import 'package:coin_tracker/tools/notificaton_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService {

  Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();

  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();
    service.setNotificationInfo(
      title: "My App Service",
      content: "Updated at ${DateTime.now()}",
    );

    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.sendData(
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}

  static var apiController = Get.put(ApiController());
  static const myTask = "syncWithTheBackEnd";
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      
          await apiController.getBtcPrice().then((value) async {
            await NotificationService().showNotifications();
          });
      switch (task) {
        case myTask:
          
          print("this method was called from native!");
          break;
        case Workmanager.iOSBackgroundTask:
          print("iOS background fetch delegate ran");
          break;
      } 
      //simpleTask will be emitted here.
      return Future.value(true);
    });
  }

  Future<void> init() async{
   await Workmanager().initialize(callbackDispatcher, isInDebugMode: false).then((value) => print('go go go'));
  }

 void registerRecurrentTask() {
    Workmanager()
        .registerPeriodicTask(
          "2",
          myTask,
          constraints: Constraints(
            requiresCharging: false,
            networkType: NetworkType.connected,
            requiresDeviceIdle: false,
            requiresStorageNotLow: false,
          ),
          frequency: Duration(minutes: 15),
        )
        .then(
          (value) => print('recurrentTask initialized'),
        );
  }

 void registerOneOff() {
    Workmanager()
        .registerOneOffTask(
          "1",
          myTask, //This is the value that will be returned in the callbackDispatcher
          initialDelay: Duration(seconds: 30),
          constraints: Constraints(
            requiresCharging: false,
            networkType: NetworkType.connected,
            requiresDeviceIdle: false,
            requiresStorageNotLow: false,
          ),
        )
        .then((value) => print('registered'));
  }
}
