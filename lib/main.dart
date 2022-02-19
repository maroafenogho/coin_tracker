import 'dart:io';
// import 'package:flutter/services.dart';
import 'dart:async';
import 'package:coin_tracker/tools/background_worker.dart';
import 'package:coin_tracker/tools/notificaton_handler.dart';
import 'package:coin_tracker/tools/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

const myTask = "syncWithTheBackEnd";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationService().showNotifications();
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager()
      .initialize(callbackDispatcher, isInDebugMode: true)
      .then((value) => print('done'));
  await Firebase.initializeApp();
  await Hive.initFlutter();
  HttpOverrides.global = MyHttpOverrides();
  await NotificationService().init().then((value) {
    print('Notifications initialized');
  });
  await BackgroundService().initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coin Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
