import 'package:coin_tracker/app/constants/app_constants.dart';
import 'package:coin_tracker/app/modules/home/notifiers/home_notifier.dart';
import 'package:coin_tracker/app/modules/settings/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeOn = ref.watch(darkModeActive);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarBrightness: darkModeOn ? Brightness.dark : Brightness.light,
          // statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent),
      child: Scaffold(
        body: SizedBox.expand(
            child: ref
                .watch(homeWidgetsProvider)[ref.watch(bottomBarIndexProvider)]),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: darkModeOn
              ? AppConstants.backgroundColorDark
              : AppConstants.backgroundColor,
          selectedItemColor: darkModeOn ? Colors.teal[200] : Colors.teal[500],
          unselectedItemColor: Color.fromARGB(255, 2, 54, 48),
          currentIndex: ref.watch(bottomBarIndexProvider),
          onTap: (index) {
            ref.read(bottomBarIndexProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: 'Coins'),
            BottomNavigationBarItem(
                icon: Icon(Icons.token_sharp), label: 'Coins'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Account'),

            // BottomNavigationBarItem(
            //     icon: Icon(Icons.account_balance_wallet), label: 'Coins'),
          ],
        ),
      ),
    );
  }
}
