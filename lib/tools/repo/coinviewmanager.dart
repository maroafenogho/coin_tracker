import 'package:coin_tracker/tools/coin_info.dart';

class CoinViewManager {
  CoinInfo? coinInfo;
  CoinViewManager({this.coinInfo});

  int get coinPrice {
    return int.parse(coinInfo!.coinPrice!.toStringAsFixed(0));
  }

  String get coinName {
    return coinInfo!.coinName!;
  }

  String get fiatCurrency {
    return coinInfo!.fiat!;
  }
}
