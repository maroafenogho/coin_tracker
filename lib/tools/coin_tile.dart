import 'package:coin_tracker/tools/coin_info.dart';
import 'package:coin_tracker/tools/repo/coinviewmanager.dart';
import 'package:coin_tracker/tools/repo/coinrepo.dart';
import 'package:coin_tracker/tools/repo/coinsviewmodel.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({Key? key, required this.coins}) : super(key: key);
  final List<CoinViewManager> coins;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final coin = coins[index];
        return Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              '${coin.coinName} is currently ${coin.coinPrice} ${coin.fiatCurrency}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      )
   ;
      },
      itemCount: coins.length,
    );
  }
}
