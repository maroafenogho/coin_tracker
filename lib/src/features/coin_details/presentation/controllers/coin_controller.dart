import 'dart:async';

import 'package:coin_tracker/src/features/coin_details/data/repositories/coins_repo.dart';
import 'package:coin_tracker/src/features/coin_details/domain/coins_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final coinsList = StateProvider<List<CoinModel>>((ref) {
  return [];
});

final selectedDays = StateProvider((ref) => '1');

final daysList = Provider((ref) => ['1D', '1W', '1M', '1Y', 'MAX']);

final coinsRepoProvider = Provider((ref) => CoinsRepository());

final timerProvider = StateProvider<int>((ref) => 10);
final asyncCoinProvider =
    AsyncNotifierProvider<AsyncCoinsNotifier, List<CoinModel>>(
  () {
    return AsyncCoinsNotifier();
  },
);

class AsyncCoinsNotifier extends AsyncNotifier<List<CoinModel>> {
  AsyncCoinsNotifier();

  @override
  FutureOr<List<CoinModel>> build() {
    return getCoins();
  }

  Future<List<CoinModel>> getCoins() async {
    state = const AsyncValue.loading();
    List<CoinModel> coinsList = [];
    state = await AsyncValue.guard<List<CoinModel>>(() async {
      final coins = await ref.watch(coinsRepoProvider).getCoins();

      coinsList = coins;
      return coinsList;
    });

    return coinsList;
  }
}

final asyncChartProvider =
    AsyncNotifierProvider<AsyncChartNotifier, List<FlSpot>>(
        () => AsyncChartNotifier());

class AsyncChartNotifier extends AsyncNotifier<List<FlSpot>> {
  @override
  FutureOr<List<FlSpot>> build() {
    return getCoinChart(ref.watch(selectedDays), ref.watch(selectedCoin).id);
  }

  Future<List<FlSpot>> getCoinChart(String days, String id) async {
    state = const AsyncLoading();
    List<FlSpot> chartList = [];
    state = await AsyncValue.guard<List<FlSpot>>(() async {
      final list = await ref.watch(coinsRepoProvider).getChart(id, days);
      chartList = list;
      return chartList;
    });
    return chartList;
  }
}
