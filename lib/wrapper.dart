// import 'package:coin_tracker/app/modules/auth/notifiers/user_notifier.dart';
// import 'package:coin_tracker/app/modules/coins/screens/coins_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Wrapper extends ConsumerWidget {
//   const Wrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userStreamProvder);

//     return user.when(
//         data: (user) {
//           if (user == null) {
//             return const CoinsHomepage();
//           } else {
//             return const CoinsHomepage();
//           }
//         },
//         error: (error, stackTrace) {
//           return const SizedBox();
//         },
//         loading: () => const CircularProgressIndicator());
//   }
// }
