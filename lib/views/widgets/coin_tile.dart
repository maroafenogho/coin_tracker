import 'package:coin_tracker/view_models/hiveListViewModel.dart';
import 'package:coin_tracker/view_models/hiveviewmodel.dart';
import 'package:coin_tracker/view_models/notificationsviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinTile extends StatelessWidget {
  CoinTile({Key? key, required this.coinList}) : super(key: key);
  // final List<CoinViewManager> coins;
  final List<NotificationsViewModel> coinList;
  var hiveController = Get.put(HiveListViewModel());

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
                    '${coin.coinName} ${coin.directionWord} from \$${coin.oldPrice} to \$${coin.newPrice}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // Text(
                  //   coin.time,
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.green,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
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

void calculate() {}
