import 'package:coin_tracker/services/auth_service.dart';
import 'package:coin_tracker/views/widgets/coin_tile.dart';
import 'package:coin_tracker/view_models/hiveListViewModel.dart';
import 'package:coin_tracker/services/notificaton_handler.dart';
import 'package:coin_tracker/view_models/coinsviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/hive_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  // final apiController = Get.put(ApiController());
  final hiveVm = Get.put(HiveListViewModel());
  final authController = Get.put(AuthController());
  final vmController = Get.put(CoinsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HiveListViewModel>(
          builder: ((_) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello ${authController.userName}'),
                    Row(
                      children: [
                        SizedBox(
                          child: TextButton(
                              onPressed: () async {
                                hiveVm.getOldPrices();
                                await vmController.getCoins().then((value) {
                                  if (hiveVm.hiveDbList.isNotEmpty) {
                                    hiveVm.calculate();
                                  }
                                  hiveVm.updateHiveDb();
                                  hiveVm.getHiveDb();
                                  hiveVm.getNotificationsList();
                                });
                                // hiveVm.getNotificationsList();
                              },
                              child: const Text('Get Current prices')),
                        ),
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                // hiveVm.getOldPrices();
                                authController.signOut();
                                // hiveVm.deleteDatabase();
                                // Workmanager().cancelAll();
                              },
                              child: const Text('logout')),
                        ),
                        SizedBox(
                          child: TextButton(
                              onPressed: () async {
                                // await NotificationService().showNotifications();
                              },
                              child: const Text('Show notification')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width,
                      child: hiveVm.notificationsList.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.white,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SizedBox(
                              child:
                                  CoinTile(coinList: hiveVm.notificationsList),
                            ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
