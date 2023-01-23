import 'package:coin_tracker/src/common/app_typography.dart';
import 'package:coin_tracker/src/features/coin_details/presentation/controllers/coin_controller.dart';
import 'package:coin_tracker/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoinsHomepage extends StatelessWidget {
  const CoinsHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (((context, ref, child) {
        final asyncCoins = ref.watch(asyncCoinProvider);
        final newCoinList = ref.watch(coinsList);

        return asyncCoins.when(
            data: (coin) {
              // Timer.periodic(const Duration(seconds: 2), (timer) {
              //   ref.refresh(coinStreamProvider);
              // });
              return SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: () =>
                      ref.watch(asyncCoinProvider.notifier).getCoins(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      ExpansionPanelList(
                        dividerColor: Colors.transparent,
                        expandedHeaderPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        elevation: 0,
                        expansionCallback: (panelIndex, isExpanded) {
                          ref
                              .read(asyncCoinProvider.notifier)
                              .state
                              .value!
                              .elementAt(panelIndex)
                              .isExpanded = !isExpanded;
                          ref
                              .watch(asyncCoinProvider.notifier)
                              .ref
                              .notifyListeners();
                          // coin = ref
                          //     .watch(asyncCoinProvider.notifier)
                          //     .state
                          //     .value!;

                          // ref.read(selectedCoin.notifier).state =
                          //     coin[panelIndex];
                          // ref.read(selectedCoin.notifier).state.isExpanded =
                          //     !isExpanded;
                          // print(ref.watch(selectedCoin).name);
                          // print(ref.watch(selectedCoin).isExpanded);
                          // coin[panelIndex].isExpanded = isExpanded;
                        },
                        // dividerColor: Colors.transparent,
                        children: coin
                            .map<ExpansionPanel>((coinmodel) => ExpansionPanel(
                                canTapOnHeader: true,
                                isExpanded: coinmodel.isExpanded,
                                headerBuilder: ((context, isExpanded) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.teal),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                    coinmodel.image,
                                                  ))),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    coinmodel.symbol
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    coinmodel.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                coinmodel.priceChangePercent > 0
                                                    ? '+${coinmodel.priceChangePercent.toStringAsFixed(2)}%'
                                                    : '${coinmodel.priceChangePercent.toStringAsFixed(2)}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: coinmodel
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
                                                '\$${coinmodel.currentPrice}',
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                }),
                                body: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('All-Time-High: ',
                                                  style: AppTypography
                                                      .expandedText),
                                              Text(
                                                  '\$${coinmodel.ath.formattedNumber}',
                                                  style: AppTypography
                                                      .expandedText),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Total Supply: ',
                                                  style: AppTypography
                                                      .expandedText),
                                              Text(
                                                  coinmodel.totalSupply
                                                      .formattedNumber,
                                                  style: AppTypography
                                                      .expandedText),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Market Cap: ',
                                                  style: AppTypography
                                                      .expandedText),
                                              Text(
                                                  '\$${coinmodel.marketCap.formattedNumber}',
                                                  style: AppTypography
                                                      .expandedText),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('All-Time-Low: ',
                                                  style: AppTypography
                                                      .expandedText),
                                              Text(
                                                  '\$${coinmodel.atl.formattedNumber}',
                                                  style: AppTypography
                                                      .expandedText),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Max Supply: ',
                                                  style: AppTypography
                                                      .expandedText),
                                              Text(
                                                  coinmodel.maxSupply
                                                      .formattedNumber,
                                                  style: AppTypography
                                                      .expandedText),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Market Rank: ',
                                                  style: AppTypography
                                                      .expandedText),
                                              Text('${coinmodel.marketRank}',
                                                  style: AppTypography
                                                      .expandedText),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )))
                            .toList(),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.9,
                      //   child: ListView.builder(
                      //     itemCount: coin.length,
                      //     itemBuilder: (context, index) => Container(
                      //       padding: const EdgeInsets.symmetric(horizontal: 30),
                      //       child: Column(
                      //         children: [
                      //           const SizedBox(
                      //             height: 10,
                      //           ),
                      //           InkWell(
                      //             onTap: () {
                      //               ref.read(selectedCoin.notifier).state =
                      //                   coin[index];
                      //               print(ref.watch(selectedCoin).name);
                      //             },
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       Text(
                      //                         coin[index].symbol.toUpperCase(),
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.w700,
                      //                           fontSize: 18,
                      //                         ),
                      //                       ),
                      //                       Text(
                      //                         coin[index].name,
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.w300,
                      //                           fontSize: 12,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Expanded(
                      //                   flex: 1,
                      //                   child: Text(
                      //                     coin[index].priceChangePercent > 0
                      //                         ? '+${coin[index].priceChangePercent.toStringAsFixed(2)}%'
                      //                         : '${coin[index].priceChangePercent.toStringAsFixed(2)}%',
                      //                     style: TextStyle(
                      //                       fontWeight: FontWeight.w500,
                      //                       fontSize: 14,
                      //                       color:
                      //                           coin[index].priceChangePercent >
                      //                                   0
                      //                               ? Colors.green
                      //                               : Colors.red,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Text(
                      //                     '\$${coin[index].currentPrice}',
                      //                     textAlign: TextAlign.end,
                      //                     style: const TextStyle(
                      //                       fontWeight: FontWeight.w700,
                      //                       fontSize: 18,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           const Divider(
                      //             color: Colors.black54,
                      //             height: 2,
                      //           ),
                      //           const SizedBox(
                      //             height: 10,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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
      }))),
    );
  }
}

//  ListView.builder(
//                           itemCount: coin.length,
//                           itemBuilder: (context, index) => Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 30),
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     ref.read(selectedCoin.notifier).state =
//                                         coin[index];
//                                     print(ref.watch(selectedCoin).name);
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               coin[index].symbol.toUpperCase(),
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             Text(
//                                               coin[index].name,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w300,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Text(
//                                           coin[index].priceChangePercent > 0
//                                               ? '+${coin[index].priceChangePercent.toStringAsFixed(2)}%'
//                                               : '${coin[index].priceChangePercent.toStringAsFixed(2)}%',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 14,
//                                             color:
//                                                 coin[index].priceChangePercent >
//                                                         0
//                                                     ? Colors.green
//                                                     : Colors.red,
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           '\$${coin[index].currentPrice}',
//                                           textAlign: TextAlign.end,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const Divider(
//                                   color: Colors.black54,
//                                   height: 2,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
