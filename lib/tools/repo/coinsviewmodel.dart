import 'package:coin_tracker/tools/repo/coinviewmanager.dart';
import 'package:coin_tracker/tools/repo/coinrepo.dart';

import 'package:get/get.dart';

class CoinsViewModel extends GetxController {
  List<CoinViewManager> coins = [];


  int? ethPrice;
  int? btcPrice;

  Future<void> getBtc() async {
    final results = await MainRepo().getBtcInfo();
    coins = results.map((info) => CoinViewManager(coinInfo: info)).toList();
    print(coins);
    btcPrice = coins[1].coinPrice;
    print(btcPrice);
    update();
  }
}
