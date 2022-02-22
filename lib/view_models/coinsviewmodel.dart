import 'package:coin_tracker/view_models/coinviewmanager.dart';
import 'package:coin_tracker/repository/maincoinrepo.dart';

import 'package:get/get.dart';

class CoinsViewModel extends GetxController {
  List<CoinViewManager> coins = [];

  int? ethPrice;
  int? btcPrice;

  Future<void> getCoins() async {
    final results = await MainCoinRepo().getAssetsInfo();
    coins = results.map((info) => CoinViewManager(coinInfo: info)).toList();
    print(DateTime.now());
    btcPrice = coins[0].coinPrice;
    ethPrice = coins[1].coinPrice;
    print(btcPrice);
    update();
  }
}
