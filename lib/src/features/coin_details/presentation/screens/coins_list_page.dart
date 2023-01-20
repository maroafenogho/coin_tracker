import 'package:coin_tracker/src/features/coin_details/presentation/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinsHomepage extends StatelessWidget {
  const CoinsHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Consumer(builder: (((context, ref, child) {
          final asyncCoins = ref.watch(asyncCoinProvider);

          return asyncCoins.when(
              data: (coin) {
                // Timer.periodic(const Duration(seconds: 2), (timer) {
                //   ref.refresh(coinStreamProvider);
                // });
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: coin.length,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(selectedCoin.notifier).state =
                                  coin[index];
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
                                        coin[index].symbol.toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        coin[index].name,
                                        style: const TextStyle(
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
                                    coin[index].priceChangePercent > 0
                                        ? '+${coin[index].priceChangePercent.toStringAsFixed(2)}%'
                                        : '${coin[index].priceChangePercent.toStringAsFixed(2)}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: coin[index].priceChangePercent > 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '\$${coin[index].currentPrice}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.black54,
                            height: 2,
                          ),
                          const SizedBox(
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
                return const Text('error');
              },
              loading: () => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator())));
        })))
      ]),
    );
  }
}
