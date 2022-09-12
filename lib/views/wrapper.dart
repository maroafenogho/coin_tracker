import 'package:coin_tracker/app/modules/auth/notifiers/user_notifier.dart';
import 'package:coin_tracker/app/modules/coins/notifiers/coins_state_notifiers.dart';
import 'package:coin_tracker/app/modules/coins/screens/coins_list_page.dart';
import 'package:coin_tracker/views/auth_screens/login.dart';
import 'package:coin_tracker/views/home.dart';
import 'package:coin_tracker/services/auth_service.dart';
import 'package:coin_tracker/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = Get.put(AuthController());

//     return StreamBuilder<User?>(
//       stream: authService.user,
//       builder: (_, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final User? user = snapshot.data;
//           return user == null ? Login() : HomeScreen();
//         } else {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class Wrapper extends ConsumerWidget {
  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStreamProvder);
    // final coinsProvider = ref.wa
    // user.when(
    //     data: (user) {
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => const CoinsHomepage(),
    //           ));
    //     },
    //     error: error,
    //     loading: () => CircularProgressIndicator());
    return user.when(
        data: (user) {
          if (user == null) {
            return Login();
          } else {
            // ref.read(coinsNotifierProvider.notifier).getCoins();
            return const CoinsHomepage();
          }
        },
        error: (error, stackTrace) {
          return const SizedBox();
        },
        loading: () => CircularProgressIndicator());
  }
}
