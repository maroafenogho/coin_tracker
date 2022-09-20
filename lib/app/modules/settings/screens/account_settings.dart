import 'dart:async';

import 'package:coin_tracker/app/modules/auth/notifiers/user_notifier.dart';
import 'package:coin_tracker/app/modules/auth/screens/login.dart';
import 'package:coin_tracker/app/modules/coins/notifiers/coins_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AccountSettings extends ConsumerWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            Text('Account Settings', style: TextStyle(color: Colors.teal[700])),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'User Data',
            style: TextStyle(
                color: Colors.teal[700],
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          // Divider(color: Colors.teal[300]),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.teal.shade100.withAlpha(100),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Column(
              children: [
                SettingsItem(
                  leftText: 'Display Name',
                  rightText: ref
                      .watch(loggedInUserProvider.notifier)
                      .state
                      .displayName!,
                ),
                SettingsItem(
                  leftText: 'Email Address',
                  rightText:
                      ref.watch(loggedInUserProvider.notifier).state.email!,
                ),
                SettingsItem(
                  leftText: 'Verification status',
                  rightText: ref
                          .watch(loggedInUserProvider.notifier)
                          .state
                          .emailVerified!
                      ? 'Verified'
                      : 'Not Verified',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: InkWell(
              onTap: () {
                final logout = ref.watch(loogedOut);
                logout.whenData((value) {
                  if (value) {
                    Get.offAll(LoginRiv());
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Logout', style: TextStyle(color: Colors.teal[700])),
                  Icon(
                    Icons.logout,
                    color: Colors.teal[300],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.leftText,
    required this.rightText,
  }) : super(key: key);

  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(color: Colors.teal[700]),
            ),
            Text(rightText, style: TextStyle(color: Colors.teal[400])),
          ],
        ),
        Divider(color: Colors.teal[300]),
      ],
    );
  }
}
