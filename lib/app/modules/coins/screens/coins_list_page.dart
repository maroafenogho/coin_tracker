import 'package:coin_tracker/app/constants/app_constants.dart';
import 'package:coin_tracker/app/modules/coins/notifiers/coins_state_notifiers.dart';
import 'package:coin_tracker/app/modules/settings/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinsHomepage extends ConsumerWidget {
  CoinsHomepage({Key? key}) : super(key: key);
  final focusTextField = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeOn = ref.watch(darkModeActive);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: darkModeOn
      //       ? AppConstants.backgroundColorDark
      //       : AppConstants.backgroundColor,
      //   elevation: 0,
      // ),
      backgroundColor: darkModeOn
          ? AppConstants.backgroundColorDark
          : AppConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Focus(
                  focusNode: focusTextField,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        fillColor: darkModeOn
                            ? AppConstants.backgroundColor
                            : AppConstants.backgroundColorDark,
                        hintText: 'Search Coins',
                        hintStyle: TextStyle(
                            color: darkModeOn
                                ? AppConstants.subTextColorDark
                                : AppConstants.subTextColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0,
                                color: darkModeOn
                                    ? AppConstants.backgroundColor
                                    : AppConstants.backgroundColorDark))),
                  ),
                ),
              ),
            ),
          ),
          Consumer(builder: (((context, ref, child) {
            // Timer.periodic(Duration(seconds: 60),
            //     (timer) => ref.refresh(coinsFutureProvider));
            final coins = ref.watch(coinsFutureProvider);
            // final coinStream = ref.watch(coinStreamProvider);
            return RefreshIndicator(
              onRefresh: () async => await ref.refresh(coinsFutureProvider),
              child: coins.when(data: (coins) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    ref.read(coinsCacheProvider.state).state = coins;
                  },
                );
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
                                          color: darkModeOn
                                              ? AppConstants.mainTextColorDark
                                              : AppConstants.mainTextColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        coins[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: darkModeOn
                                              ? AppConstants.subTextColorDark
                                              : AppConstants.subTextColor,
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
                                      color: darkModeOn
                                          ? AppConstants.mainTextColorDark
                                          : AppConstants.mainTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: darkModeOn
                                ? AppConstants.mainTextColorDark
                                : AppConstants.mainTextColor,
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
              }, error: (error, stacktrace) {
                print(stacktrace);
                return Text('error');
              }, loading: () {
                final cachedList = ref.watch(coinsCacheProvider);

                return cachedList.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: cachedList.length,
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
                                        cachedList[index];
                                    print(ref.watch(selectedCoin).name);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cachedList[index]
                                                  .symbol
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              cachedList[index].name,
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
                                          cachedList[index].priceChangePercent >
                                                  0
                                              ? '+${cachedList[index].priceChangePercent.toStringAsFixed(2)}%'
                                              : '${cachedList[index].priceChangePercent.toStringAsFixed(2)}%',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: cachedList[index]
                                                        .priceChangePercent >
                                                    0
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '\$${cachedList[index].currentPrice}',
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
              }),
            );
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
      ),
    );
  }
}
