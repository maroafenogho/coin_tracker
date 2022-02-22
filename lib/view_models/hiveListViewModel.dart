import 'package:coin_tracker/services/hive_service.dart';
import 'package:coin_tracker/view_models/coinviewmanager.dart';
import 'package:coin_tracker/view_models/hiveviewmodel.dart';
import 'package:coin_tracker/view_models/coinsviewmodel.dart';
import 'package:get/get.dart';

class HiveListViewModel extends GetxController {
  List<HiveViewModel> hiveDbList = [];
  final vmController = Get.put(CoinsViewModel());
  final coinData = CoinViewManager();

  void getHiveDb() {
    final result = HiveService().getCoins();
    hiveDbList = result.map((e) => HiveViewModel(hiveModel: e)).toList();
    // print(hiveDbList);
    update();
  }

  void updateHiveDb() {
    HiveService().addCoinDetails(
      coinName: coinData.coinName,
      coinPrice: coinData.coinPrice,
      time:
          '${DateTime.now().hour}:${DateTime.now().minute},  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    );
    update();
  }
}
