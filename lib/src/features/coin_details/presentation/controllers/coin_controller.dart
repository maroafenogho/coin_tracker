import 'package:coin_tracker/app/modules/coins/repository/coins_repository.dart';
import 'package:coin_tracker/src/features/coin_details/domain/coins_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinsFutureProvider = FutureProvider<List<CoinModel>>((ref) async {
  final coinsList = await CoinsApiService().getCoins();
  return coinsList;
});

final selectedCoin = StateProvider<CoinModel>(
  (ref) => CoinModel(
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

final coinStreamProvider = StreamProvider<List<CoinModel>>((ref) async* {
  final coinsList = await ref.watch(coinsApiService).getCoins();
  yield coinsList;
});

final coinsApiService = Provider<CoinsApiService>((ref) => CoinsApiService());

final coinsRepositoryProvider = Provider<CoinsRepository>(
  (ref) => CoinsRepository(),
);

final coinsNotifierProvider =
    StateNotifierProvider<CoinsNotifier, AsyncValue<void>>((ref) {
  return CoinsNotifier(ref.watch(coinsRepositoryProvider));
});

class CoinsNotifier extends StateNotifier<AsyncValue<void>> {
  CoinsNotifier(this._coinsRepository) : super(const AsyncData<void>(null));
  final CoinsRepository _coinsRepository;

  getCoins() async {
    state = const AsyncLoading();

    final coinsList = <CoinModel>[];
    state = await AsyncValue.guard<List<CoinModel>>(() async {
      final coins = await _coinsRepository.getCoins();

      for (final coin in coins) {
        coinsList.add(
          CoinModel(
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
    });
    // final coins = await _coinsRepository.getCoins();

    // for (final coin in coins) {
    //   coinsList.add(
    //     Coins(
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
    //   // print()

    // }
  }
}
