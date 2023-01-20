import 'package:coin_tracker/src/features/coin_details/data/services/api_service.dart';
import 'package:coin_tracker/src/features/coin_details/domain/coins_model.dart';

class CoinsRepository {
  CoinsRepository({CoinsApiService? apiService})
      : _apiService = apiService ?? CoinsApiService();
  final CoinsApiService _apiService;

  Future<List<CoinModel>> getCoins() async {
    List<CoinModel> coinsList = [];
    final coins = await _apiService.getCoins();
    coinsList = coins;
    // for (final coin in coins) {

    //   coinsList.add(
    //     CoinModel(
    //       id: coin.id,
    //       symbol: coin.symbol,
    //       ath: coin.ath,
    //       athChangePercent: coin.athChangePercent,
    //       circulatingSupply: coin.circulatingSupply,
    //       currentPrice: coin.currentPrice,
    //       high24Hour: coin.high24Hour,
    //       image: coin.image,
    //       low24Hour: coin.low24Hour,
    //       marketCap: coin.marketCap,
    //       marketRank: coin.marketRank,
    //       maxSupply: coin.maxSupply,
    //       name: coin.name,
    //       priceChange: coin.priceChange,
    //       priceChangePercent: coin.priceChangePercent,
    //       totalSupply: coin.totalSupply,
    //       totalVolume: coin.totalVolume,
    //       atl: coin.atl,
    //       athDate: coin.athDate,
    //       atlDate: coin.atlDate,
    //       atlChangePercent: coin.atlChangePercent,
    //     ),
    //   );
    // }
    return coinsList;
  }
}
