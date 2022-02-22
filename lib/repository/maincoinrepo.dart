import 'dart:convert';

import 'package:coin_tracker/models/coin_info.dart';
import 'package:coin_tracker/repository/coinrepo.dart';
import 'package:http/http.dart' as http;

class MainCoinRepo implements CoinRepo {
  final url = 'https://rest.coinapi.io/v1/exchangerate';
  final apiKey = 'ABD08DD2-2665-4A65-8BBF-CF3162D66BDF';

  List<String> asset = ['BTC', 'ETH'];

  @override
  Future<List<CoinInfo>> getAssetsInfo() async {
    List<CoinInfo> coinList = [];
    for (var coin in asset) {
      String newUrl = '$url/$coin/USD?apiKey=$apiKey';
      var response = await http.get(Uri.parse(newUrl));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        coinList.add(CoinInfo.fromJson(jsonResponse));
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    }
    return coinList;
  }
}
