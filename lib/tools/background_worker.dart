import 'dart:async';
import 'package:coin_tracker/tools/repo/coinsviewmodel.dart';
import 'package:coin_tracker/tools/notificaton_handler.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService {
  
  static var apiController = Get.put(CoinsViewModel());
  static const myTask = "syncWithTheBackEnd";
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      await apiController.getCoins().then((value) async {
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

  Future<void> init() async {
    await Workmanager()
        .initialize(callbackDispatcher, isInDebugMode: false)
        .then((value) => print('go go go'));
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
