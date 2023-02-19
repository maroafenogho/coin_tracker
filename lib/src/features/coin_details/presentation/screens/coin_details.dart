import 'package:coin_tracker/src/common/app_constants.dart';
import 'package:coin_tracker/src/common/app_typography.dart';
import 'package:coin_tracker/src/features/coin_details/presentation/controllers/coin_controller.dart';
import 'package:coin_tracker/src/utils/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CoinDetailsView extends StatelessWidget {
  const CoinDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final chartList = ref.watch(asyncChartProvider);
        // final slected = ref.watch(selectedCoin);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Constants.mainColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text(
                        '${ref.watch(selectedCoin).symbol.toUpperCase()}/USD',
                        style: const TextStyle(
                            color: Colors.teal,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        '\$${ref.watch(selectedCoin).currentPrice}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Text(' '),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.teal,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: chartList.when(data: (data) {
                    return LineChart(LineChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        clipData: FlClipData.horizontal(),
                        lineBarsData: [
                          LineChartBarData(
                            spots: data,
                            dotData: FlDotData(show: false),
                            preventCurveOverShooting: true,
                            color: Colors.teal,
                            isCurved: true,
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: false,
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            showOnTopOfTheChartBoxArea: true,
                            maxContentWidth: 200,
                            fitInsideVertically: true,
                            fitInsideHorizontally: true,
                            tooltipRoundedRadius: 20,
                            tooltipBgColor: Colors.teal.shade100,
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                final time = DateFormat("HH:mma")
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        spot.x.intFromDouble))
                                    .toString();

                                final date = DateFormat("dd/MM/yyy")
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        spot.x.intFromDouble))
                                    .toString();
                                return LineTooltipItem(
                                  '\$${spot.y.toStringAsFixed(2)}',
                                  AppTypography.expandedText
                                      .copyWith(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '\n$time\n$date',
                                      style: AppTypography.expandedText
                                          .copyWith(color: Colors.black),
                                    )
                                  ],
                                );
                              }).toList();
                            },
                          ),
                        )));
                  }, error: (error, stackTrace) {
                    return const SizedBox();
                  }, loading: () {
                    return const CircularProgressIndicator(
                        color: Constants.mainColor);
                  }),
                )),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.teal,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ref.watch(daysList).length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref.read(selectedDays.notifier).state =
                            ref.watch(daysList)[index];
                        ref.read(asyncChartProvider.notifier).getCoinChart(
                            ref.watch(selectedDays).formattedDay,
                            ref.watch(selectedCoin).id);
                        // ref
                        //     .watch(asyncCoinProvider.notifier)
                        // .ref
                        // .notifyListeners();
                      },
                      child: Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: ref.read(selectedDays.notifier).state ==
                                    ref.watch(daysList)[index]
                                ? Constants.mainColor
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ref.watch(daysList)[index],
                            style: TextStyle(
                                color: ref.read(selectedDays.notifier).state ==
                                        ref.watch(daysList)[index]
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(
              color: Colors.teal,
              thickness: 1,
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    )));
  }
}
