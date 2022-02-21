import 'package:coin_tracker/tools/hive/hiveviewmodel.dart';
import 'package:coin_tracker/tools/repo/coinviewmanager.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({Key? key, required this.coinList}) : super(key: key);
  // final List<CoinViewManager> coins;
  final List<HiveViewModel> coinList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        final coin = coinList[index];
        return Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BTC is ${coin.btcPrice}USD and Eth is currently ${coin.ethPrice}USD ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    coin.time,
                    // '${DateTime.now().hour}:${DateTime.now().minute},  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: coinList.length,
    );
  }
}
