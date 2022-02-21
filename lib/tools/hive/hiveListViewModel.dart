import 'package:coin_tracker/tools/hive/hive_service.dart';
import 'package:coin_tracker/tools/hive/hiveviewmodel.dart';
import 'package:coin_tracker/tools/repo/coinsviewmodel.dart';
import 'package:get/get.dart';

class HiveListViewModel extends GetxController {
  List<HiveViewModel> hiveDbList = [];
  final vmController = Get.put(CoinsViewModel());

  void getHiveDb() {
    final result = HiveService().getCoins();
    hiveDbList = result.map((e) => HiveViewModel(hiveModel: e)).toList();
    // print(hiveDbList);
    update();
  }

  void updateHiveDb() {
    HiveService().addCoinDetails(
      btcPrice: vmController.btcPrice,
      ethPrice: vmController.ethPrice,
      date:
          '${DateTime.now().hour}:${DateTime.now().minute},  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    );
    update();
  }
}
