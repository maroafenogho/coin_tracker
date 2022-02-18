import 'package:coin_tracker/tools/api_service.dart';
import 'package:coin_tracker/tools/notificaton_handler.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService {
  static var apiController = Get.put(ApiController());
  static const myTask = "syncWithTheBackEnd";
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case myTask:
          await NotificationService().showNotifications();
          await apiController.getEthPrice();
          await apiController.getBtcPrice().then((value) async {
            await NotificationService().showNotifications();
          });
          print("this method was called from native!");
          break;
        case Workmanager.iOSBackgroundTask:
          print("iOS background fetch delegate ran");
          break;
      } //simpleTask will be emitted here.
      return Future.value(true);
    });
  }

  void init() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  void doThese() async {
    await NotificationService().showNotifications();
    await apiController.getEthPrice();
    await apiController.getBtcPrice().then((value) async {
      await NotificationService().showNotifications();
    });
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
          initialDelay: Duration(minutes: 3),
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
