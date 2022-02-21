import 'package:coin_tracker/tools/hive/hivemodel.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  var coinsBox = Hive.box('coins');
  Future addCoinDetails({
    int? btcPrice,
    int? ethPrice,
    String? date,
  }) async {
    await coinsBox
        .add({'btcPrice': btcPrice, 'ethPrice': ethPrice, 'date': date}).then(
            (value) => print(coinsBox));
  }

  Future getCoinDetails() async {
    print(coinsBox.values);
    await coinsBox.get('btcPrice');
  }

  delete() async {
    await coinsBox.clear().then((value) => print('done'));
  }

  List<HiveModel> getCoins() {
    final Iterable coin = coinsBox.values;
    return coin.map((value) => HiveModel.fromMap(value)).toList();
  }

  // List<HiveModel> getCoins() {
  //   List<HiveModel> hList = [];
  //   final Iterable coins = coinsBox.values;
  //   for (var item in coins) {
  //     hList.add(item);
  //   }
  //   return hList;
  //   // return coin.map((e) => HiveModel.fromMap(e)).toList();
  // }
}
