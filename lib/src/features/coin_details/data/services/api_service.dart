import 'dart:convert';

import 'package:coin_tracker/src/features/coin_details/domain/coins_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class CoinsApiService {
  Future<List<CoinModel>> getCoins() async {
    List<CoinModel> coinsList = [];
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Iterable jsonResponse = jsonDecode(response.body);
      coinsList = jsonResponse.map((coin) => CoinModel.fromJson(coin)).toList();
    }
    return coinsList;
  }

  Future<List<FlSpot>> getChart(String id, String days) async {
    print(id);
    List<FlSpot> chartList = [];
    final url =
        'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=$days';
    final response = await http.get(Uri.parse(url));
    print('gg:${response.body}');

    if (response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body);
      for (final data in jsonResponse['prices']) {
        chartList.add(FlSpot(double.parse(data[0].toString()),
            double.parse(data[1].toString())));
      }
    } else {
      throw 'Unable to get chart data';
    }
    return chartList;
  }
}
