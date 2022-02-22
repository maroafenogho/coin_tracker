import 'package:coin_tracker/view_models/hiveviewmodel.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${coin.coinName} is \$${coin.coinPrice}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    coin.time,
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
