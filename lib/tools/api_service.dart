import 'package:coin_tracker/tools/coin_info.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiController extends GetxController {
  late String btcPrice, ethPrice;

  List<CoinInfo> coinInfoList = [];
  final url = 'https://rest.coinapi.io/v1/exchangerate';
  final apiKey = 'C6D7CAB6-DB0E-4E8E-9382-D01E8AA5FA0D';

  Future getCoinInfo() async {
    await getBtcPrice();
    await getEthPrice();
  }

  Future getBtcPrice() async {
    String newUrl = '$url/BTC/USD?apiKey=$apiKey';
    var response = await http.get(Uri.parse(newUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      coinInfoList.add(CoinInfo.fromJson(jsonResponse));
      //  return CoinInfo.fromJson(jsonResponse);
      double price = jsonResponse['rate'];
      btcPrice = price.toStringAsFixed(0);
      update();
    }
  }

  Future getEthPrice() async {
    String newUrl = '$url/ETH/USD?apiKey=$apiKey';
    var response = await http.get(Uri.parse(newUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
       coinInfoList.add(CoinInfo.fromJson(jsonResponse));
      double price = jsonResponse['rate'];
      ethPrice = price.toStringAsFixed(0);
      update();
    }
  }
}
