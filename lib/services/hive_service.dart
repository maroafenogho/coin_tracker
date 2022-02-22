import 'package:coin_tracker/models/hivemodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  var coinsBox = Hive.box('coins');
  Future addCoinDetails({
    String? coinName,
    int? coinPrice,
    String? time,
  }) async {
    await coinsBox
        .add({'coinName': coinName, 'coinPrice': coinPrice, 'time': time}).then(
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
}
