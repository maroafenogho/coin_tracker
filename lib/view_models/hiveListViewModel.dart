import 'package:coin_tracker/models/coin_info.dart';
import 'package:coin_tracker/services/hive_service.dart';
import 'package:coin_tracker/view_models/coinviewmanager.dart';
import 'package:coin_tracker/view_models/hiveviewmodel.dart';
import 'package:coin_tracker/view_models/coinsviewmodel.dart';
import 'package:get/get.dart';

class HiveListViewModel extends GetxController {
  List<HiveViewModel> hiveDbList = [];
  final vmController = Get.put(CoinsViewModel());
  List<CoinViewManager> coins = [];

  void getHiveDb() {
    final result = HiveService().getCoins();
    hiveDbList = result.map((e) => HiveViewModel(hiveModel: e)).toList();
    // print(hiveDbList);
    update();
  }

  void updateHiveDb() {
    coins = vmController.coins;
    for(var coinData in coins){
          HiveService()
        .addCoinDetails(
          coinName: coinData.coinName,
          coinPrice: coinData.coinPrice,
          time:
              '${DateTime.now().hour}:${DateTime.now().minute},  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        ).then((value) => print('updated'));
        update();
    }
    
  }
}
