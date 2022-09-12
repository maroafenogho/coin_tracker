import 'package:coin_tracker/app/modules/coins/model/coins_model.dart';
import 'package:coin_tracker/app/modules/coins/services/coins_api_service.dart';

class CoinsRepository {
  CoinsRepository({CoinsApiService? apiService})
      : _apiService = apiService ?? CoinsApiService();
  final CoinsApiService _apiService;

  Future<List<Coins>> getCoins() async {
    final List<Coins> coinsList = [];
    final coins = await _apiService.getCoins();
    for (final coin in coins) {
      coinsList.add(
        Coins(
          id: coin.id,
          symbol: coin.symbol,
          ath: coin.ath,
          athChangePercent: coin.athChangePercent,
          circulatingSupply: coin.circulatingSupply,
          currentPrice: coin.currentPrice,
          high24Hour: coin.high24Hour,
          image: coin.image,
          low24Hour: coin.low24Hour,
          marketCap: coin.marketCap,
          marketRank: coin.marketRank,
          maxSupply: coin.maxSupply,
          name: coin.name,
          priceChange: coin.priceChange,
          priceChangePercent: coin.priceChangePercent,
          totalSupply: coin.totalSupply,
          totalVolume: coin.totalVolume,
          atl: coin.atl,
          athDate: coin.athDate,
          atlDate: coin.atlDate,
          atlChangePercent: coin.atlChangePercent,
        ),
      );
    }
    return coinsList;
  }
}
