import 'package:coin_tracker/tools/api_service.dart';
import 'package:coin_tracker/tools/auth_service.dart';
import 'package:coin_tracker/tools/background_worker.dart';
import 'package:coin_tracker/tools/coin_tile.dart';
import 'package:coin_tracker/tools/notificaton_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final apiController = Get.put(ApiController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ApiController>(
        builder: ((_) => Column(
              children: [
                Container(
                  child: TextButton(
                      onPressed: () {
                        apiController.getCoinInfo();
                      },
                      child: Text('data')),
                ),
                Container(
                  child: TextButton(
                      onPressed: () {
                        // authController.signOut();
                        Workmanager().cancelAll();
                      },
                      child: Text('logout')),
                ),
                Container(
                  child: TextButton(
                      onPressed: () async {
                        // await BackgroundService().init();
                        BackgroundService().registerOneOff();
                        BackgroundService().registerRecurrentTask();
                        // await apiController.getCoinInfo().then((value) async =>
                            // await NotificationService().showNotifications());
                        // await apiController.getEthPrice();
                        // await NotificationService().showNotifications();
                        // await NotificationService().scheduleNotifications();
                        Get.snackbar('title', 'message');
                      },
                      child: Text('Show notification')),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: apiController.coinInfoList.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.white,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final coin = apiController.coinInfoList[index];
                              return Center(
                                child: CoinTile(coin: coin),
                              );
                            },
                            itemCount: apiController.coinInfoList.length,
                          ),
                        ),
                )
              ],
            )),
      )),
    );
  }
}
