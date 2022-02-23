import 'package:coin_tracker/services/hive_service.dart';
import 'package:coin_tracker/view_models/coinviewmanager.dart';
import 'package:coin_tracker/view_models/hiveviewmodel.dart';
import 'package:coin_tracker/view_models/coinsviewmodel.dart';
import 'package:coin_tracker/view_models/notificationsviewmodel.dart';
import 'package:get/get.dart';

class HiveListViewModel extends GetxController {
  List<HiveViewModel> hiveDbList = [];
  List<NotificationsViewModel> notificationsList = [];
  final vmController = Get.put(CoinsViewModel());
  List<CoinViewManager> coins = [];
  int? btcOld;
  int? ethOld;

  String? ethWord;
  String? btcWord;

  void getNotificationsList() {
    final result = HiveService().getNotifications();
    notificationsList = result
        .map((e) => NotificationsViewModel(notificationsModel: e))
        .toList();
    print(notificationsList);
    update();
  }

  void getHiveDb() {
    final result = HiveService().getCoins();
    hiveDbList = result.map((e) => HiveViewModel(hiveModel: e)).toList();
    // print(hiveDbList);
    update();
  }

  int get ethNew {
    return vmController.coins[vmController.coins.length - 1].coinPrice;
  }

  int get btcNew {
    return vmController.coins[vmController.coins.length - 2].coinPrice;
  }

  void deleteDatabase() async {
    await HiveService().delete();
  }

  void getOldPrices() {
    if (hiveDbList.isNotEmpty) {
      btcOld = hiveDbList[hiveDbList.length - 2].coinPrice;
      ethOld = hiveDbList[hiveDbList.length - 1].coinPrice;
      print(ethOld);
    } else {
      print(' database empty');
    }
    update();
  }

  void calculate() {
    if (ethNew > ethOld!) {
      ethWord = 'increased';
      HiveService()
          .addNotification(
              coinName: 'ETH',
              directionKeyword: ethWord,
              oldPrice: ethOld,
              newPrice: ethNew)
          .then((value) => getNotificationsList());
      print('Eth $ethWord from \$$ethOld to \$$ethNew');
      update();
    } else {
      ethWord = 'decreased';
      HiveService().addNotification(
          coinName: 'ETH',
          directionKeyword: ethWord,
          oldPrice: ethOld,
          newPrice: ethNew);
      print('Eth $ethWord from \$$ethOld to \$$ethNew');
      update();
    }
    if (btcNew > btcOld!) {
      btcWord = 'increased';
      HiveService().addNotification(
          coinName: 'BTC',
          directionKeyword: btcWord,
          oldPrice: btcOld,
          newPrice: btcNew);

      print('BTC $btcWord from \$$btcOld to \$$btcNew');
      update();
    } else {
      btcWord = 'decreased';
      HiveService().addNotification(
          coinName: 'BTC',
          directionKeyword: btcWord,
          oldPrice: btcOld,
          newPrice: btcNew);
      print('BTC $btcWord from \$$btcOld to \$$btcNew');
      update();
    }
  }

  void updateHiveDb() {
    coins = vmController.coins;
    for (var coinData in coins) {
      HiveService()
          .addCoinDetails(
            coinName: coinData.coinName,
            coinPrice: coinData.coinPrice,
            time:
                '${DateTime.now().hour}:${DateTime.now().minute},  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
          )
          .then((value) => print('updated'));
      update();
    }
  }
}
