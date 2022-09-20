import 'package:coin_tracker/app/modules/coins/screens/coins_list_page.dart';
import 'package:coin_tracker/app/modules/settings/screens/account_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomBarIndexProvider = StateProvider<int>((ref) => 0);
final homeWidgetsProvider = StateProvider<List<Widget>>((ref) => [
      CoinsHomepage(),
      CoinsHomepage(),
      AccountSettings(),
    ]);
