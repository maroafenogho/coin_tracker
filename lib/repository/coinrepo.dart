import 'package:coin_tracker/models/coin_info.dart';


abstract class CoinRepo {
  Future<List<CoinInfo>> getAssetsInfo();
}
