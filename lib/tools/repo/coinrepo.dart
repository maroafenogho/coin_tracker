import 'package:coin_tracker/tools/coin_info.dart';
import 'package:coin_tracker/tools/eth_info.dart';

abstract class CoinRepo {
  Future<List<CoinInfo>> getAssetsInfo();
}
