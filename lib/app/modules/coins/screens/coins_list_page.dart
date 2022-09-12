import 'package:coin_tracker/app/modules/coins/notifiers/coins_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinsHomepage extends StatelessWidget {
  const CoinsHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Consumer(builder: (((context, ref, child) {
          final coins = ref.watch(coinsFutureProvider);
          final coinStream = ref.watch(coinStreamProvider);
          return coinStream.when(
              data: (coins) {
                // Timer.periodic(const Duration(seconds: 2), (timer) {
                //   ref.refresh(coinStreamProvider);
                // });
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: coins.length,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(selectedCoin.notifier).state =
                                  coins[index];
                              print(ref.watch(selectedCoin).name);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coins[index].symbol.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        coins[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    coins[index].priceChangePercent > 0
                                        ? '+${coins[index].priceChangePercent.toStringAsFixed(2)}%'
                                        : '${coins[index].priceChangePercent.toStringAsFixed(2)}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: coins[index].priceChangePercent > 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '\$${coins[index].currentPrice}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black54,
                            height: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              error: (error, stacktrace) {
                print(stacktrace);
                return Text('error');
              },
              loading: () => Center(child: CircularProgressIndicator()));
          // final state = ref.watch(coinsNotifierProvider);
          // final state2 = ref.listen(
          //   coinsNotifierProvider,
          //   (previous, next) {},
          // );
          // switch (state.status) {
          //   case CoinStatus.initial:
          //     return SizedBox();

          //   case CoinStatus.loading:
          //     return SizedBox(
          //         height: 30, child: const CircularProgressIndicator());

          //   case CoinStatus.success:
          //     return SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.8,
          //       child: ListView.builder(
          //         itemCount: state.coins.length,
          //         itemBuilder: (context, index) => Container(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     state.coins[index].symbol.toUpperCase(),
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w500,
          //                       fontSize: 22,
          //                     ),
          //                   ),
          //                   Text(state.coins[index].name),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );

          //   case CoinStatus.error:
          //     return SizedBox(child: Text('Error'));
          //     break;
          // }
        })))
      ]),
    );
  }
}
