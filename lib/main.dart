import 'dart:io';
// import 'package:flutter/services.dart';
import 'dart:async';
import 'package:coin_tracker/services/background_worker.dart';

import 'package:coin_tracker/services/notificaton_handler.dart';
import 'package:coin_tracker/views/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await BackgroundService().initializeService();
  // await BackgroundWorker().initializeService();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('coins').then((value) => print('box opened'));
  await Hive.openBox('notifications');
  HttpOverrides.global = MyHttpOverrides();
  await NotificationService().init().then((value) {
    print('Notifications initialized');
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coin Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
