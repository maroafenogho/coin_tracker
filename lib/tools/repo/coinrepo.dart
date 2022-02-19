import 'dart:convert';

import 'package:coin_tracker/tools/coin_info.dart';
import 'package:coin_tracker/tools/repo/repo.dart';
import 'package:http/http.dart' as http;

class MainRepo implements CoinRepo {
  MainRepo({required this.client});
  final http.Client client;
  final url = 'https://rest.coinapi.io/v1/exchangerate';
  final apiKey = 'C6D7CAB6-DB0E-4E8E-9382-D01E8AA5FA0D';
  
  @override
  Future<List<CoinInfo>> getCoin() async {
    List<Map<String, dynamic>> coinsList = [];
    // TODO: implement getCoin
    String newUrl = '$url/BTC/USD?apiKey=$apiKey';
    var response = await client.get(Uri.parse(newUrl));
    var jsonResponse = jsonDecode(response.body);
    // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // CoinInfo.fromJson(jsonResponse);
    coinsList.add(jsonResponse);
    return jsonResponse.map((coin) => CoinInfo.fromJson(coin)).toList();
  }
}
