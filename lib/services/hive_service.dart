import 'package:coin_tracker/models/hivemodel.dart';
import 'package:coin_tracker/models/notificationsModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  var coinsBox = Hive.box('coins');
  var notificationsBox = Hive.box('notifications');

  Future addNotification(
      {String? coinName,
      String? directionKeyword,
      int? oldPrice,
      int? newPrice}) async {
    await notificationsBox.add({
      'coinName': coinName,
      'directionKeyWord': directionKeyword,
      'oldPrice': oldPrice,
      'newPrice': newPrice
    }).then((value) => print(notificationsBox.values));
  }

  Future addCoinDetails(
      {String? coinName, int? coinPrice, String? time}) async {
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
    // await notificationsBox.clear().then((value) => print('deleted'));
  }

  List<NotificationsModel> getNotifications() {
    final Iterable notification = notificationsBox.values;
    return notification.map((map) => NotificationsModel.fromMap(map)).toList();
  }

  List<HiveModel> getCoins() {
    final Iterable coin = coinsBox.values;
    return coin.map((value) => HiveModel.fromMap(value)).toList();
  }
}
