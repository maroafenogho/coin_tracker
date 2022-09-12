import 'dart:convert';

import 'package:coin_tracker/app/modules/coins/model/coins_model.dart';
import 'package:http/http.dart' as http;

class CoinsApiService {
  Future<List<Coins>> getCoins() async {
    print((4.6 - 5).runtimeType);

    List<Coins> coinsList = [];
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Iterable jsonResponse = jsonDecode(response.body);
      coinsList = jsonResponse.map((coin) => Coins.fromJson(coin)).toList();
    }
    return coinsList;
  }
}
