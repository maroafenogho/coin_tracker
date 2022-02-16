import 'package:coin_tracker/tools/coin_info.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiController extends GetxController {
  List<CoinInfo> coinInfoList = [];
  final url = 'https://rest.coinapi.io/v1/exchangerate';
  final apiKey = 'C6D7CAB6-DB0E-4E8E-9382-D01E8AA5FA0D';
  List<String> cryptoList = ['BTC', 'ETH'];
  Future getCoinInfo() async {
    for (String coin in cryptoList) {
      String newUrl = '$url/$coin/USD?apiKey=$apiKey';
      var response = await http.get(Uri.parse(newUrl));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        coinInfoList.add(CoinInfo.fromJson(jsonResponse));
        print(coinInfoList);
        update();
      }
    }
  }
}
