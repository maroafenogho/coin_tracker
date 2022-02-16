import 'package:coin_tracker/tools/coin_info.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({Key? key, required this.coin}) : super(key: key);
  final CoinInfo coin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: Text(
            '${coin.coinName!} is currently ${coin.coinPrice!.toStringAsFixed(0)} ${coin.fiat}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
