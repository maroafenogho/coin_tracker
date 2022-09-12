import 'package:coin_tracker/app/modules/coins/model/coins_model.dart';
import 'package:coin_tracker/app/modules/coins/notifiers/coins_state.dart';
import 'package:coin_tracker/app/modules/coins/repository/coins_repository.dart';
import 'package:coin_tracker/app/modules/coins/services/coins_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinsFutureProvider = FutureProvider<List<Coins>>((ref) async {
  final coinsList = await CoinsApiService().getCoins();
  return coinsList;
});

final selectedCoin = StateProvider<Coins>(
  (ref) => Coins(
    id: '',
    symbol: '',
    ath: 0.0,
    athChangePercent: 0.0,
    circulatingSupply: 0.0,
    currentPrice: 0.0,
    high24Hour: 0.0,
    image: '',
    low24Hour: 0.0,
    marketCap: 0.0,
    marketRank: 0,
    maxSupply: 0.0,
    name: '',
    priceChange: 0.0,
    priceChangePercent: 0.0,
    totalSupply: 0.0,
    totalVolume: 0.0,
    atl: 0.0,
    athDate: '',
    atlDate: '',
    atlChangePercent: 0.0,
  ),
);
// final timerProvider = StateProvider<>()

final coinStreamProvider = StreamProvider<List<Coins>>((ref) async* {
  final coinsList = await CoinsApiService().getCoins();
  yield coinsList;
});

final coinsRepositoryProvider = Provider<CoinsRepository>(
  (ref) => CoinsRepository(),
);
final coinsNotifierProvider =
    StateNotifierProvider<CoinsNotifier, CoinState>((ref) {
  return CoinsNotifier(ref.watch(coinsRepositoryProvider));
});

class CoinsNotifier extends StateNotifier<CoinState> {
  CoinsNotifier(this._coinsRepository) : super(CoinState.initial());
  final CoinsRepository _coinsRepository;

  getCoins() async {
    // state = state.copyWith(status: CoinStatus.loading);
    try {
      final coinsList = <Coins>[];
      final coins = await _coinsRepository.getCoins();

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
        // print()

      }
      state.copyWith(status: CoinStatus.success, coins: coinsList);
    } catch (error) {
      print(error);
      state = state.copyWith(status: CoinStatus.error);
    }
  }
}
