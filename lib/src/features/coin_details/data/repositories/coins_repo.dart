import 'package:coin_tracker/src/features/coin_details/data/services/api_service.dart';
import 'package:coin_tracker/src/features/coin_details/domain/coins_model.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinsRepository {
  CoinsRepository({CoinsApiService? apiService})
      : _apiService = apiService ?? CoinsApiService();
  final CoinsApiService _apiService;

  Future<List<CoinModel>> getCoins() async {
    List<CoinModel> coinsList = [];
    final coins = await _apiService.getCoins();
    coinsList = coins;
    return coinsList;
  }

  Future<List<FlSpot>> getChart(String id, String days) async {
    List<FlSpot> chartList = [];
    final list = await _apiService.getChart(id, days);
    chartList = list;
    return chartList;
  }
}
