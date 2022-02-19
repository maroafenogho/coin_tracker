import 'package:coin_tracker/tools/coin_info.dart';

abstract class CoinRepo {
  Future<List<CoinInfo>> getCoin();
}
