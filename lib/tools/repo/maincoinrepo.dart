import 'dart:convert';

import 'package:coin_tracker/tools/coin_info.dart';
import 'package:coin_tracker/tools/eth_info.dart';
import 'package:coin_tracker/tools/repo/coinrepo.dart';
import 'package:http/http.dart' as http;

class MainCoinRepo implements CoinRepo {
  final url = 'https://rest.coinapi.io/v1/exchangerate';
  final apiKey = 'C6D7CAB6-DB0E-4E8E-9382-D01E8AA5FA0D';

  List<String> asset = ['BTC', 'ETH'];

  @override
  Future<List<CoinInfo>> getBtcInfo() async {
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
