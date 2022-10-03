import 'package:coin_tracker/app/constants/app_constants.dart';
import 'package:coin_tracker/app/modules/auth/notifiers/user_notifier.dart';
import 'package:coin_tracker/app/modules/auth/screens/login.dart';
import 'package:coin_tracker/app/modules/coins/notifiers/coins_state_notifiers.dart';
import 'package:coin_tracker/app/modules/settings/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class AccountSettings extends ConsumerWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeOn = ref.watch(darkModeActive);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: darkModeOn ? Brightness.dark : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: darkModeOn
            ? AppConstants.backgroundColorDark
            : AppConstants.backgroundColor,
        appBar: AppBar(
          title: Text('Account Settings',
              style: TextStyle(color: Colors.teal[700])),
          centerTitle: true,
          backgroundColor: darkModeOn
              ? AppConstants.backgroundColorDark
              : AppConstants.backgroundColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'User Data',
              style: TextStyle(
                  color: darkModeOn
                      ? AppConstants.mainTextColorDark
                      : AppConstants.mainTextColor,
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
                  color: darkModeOn
                      ? AppConstants.containerColorDark
                      : AppConstants.containerColor,
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
                    darkMode: ref.watch(darkModeActive),
                  ),
                  SettingsItem(
                    leftText: 'Email Address',
                    darkMode: ref.watch(darkModeActive),
                    rightText:
                        ref.watch(loggedInUserProvider.notifier).state.email!,
                  ),
                  SettingsItem(
                    leftText: 'Verification status',
                    darkMode: ref.watch(darkModeActive),
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
            // ToggleButtons(children: [], isSelected: (value) {}),
            InkWell(
              onTap: (() {
                darkModeOn
                    ? ref.read(darkModeActive.notifier).state = false
                    : ref.read(darkModeActive.notifier).state = true;
              }),
              child: Icon(
                Icons.light_mode,
                color: darkModeOn
                    ? AppConstants.iconColorDark
                    : AppConstants.iconColor,
              ),
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
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.leftText,
    required this.rightText,
    required this.darkMode,
  }) : super(key: key);

  final String leftText;
  final bool darkMode;
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
              style: TextStyle(
                  color: darkMode
                      ? AppConstants.mainTextColorDark
                      : AppConstants.mainTextColor),
            ),
            Text(rightText,
                style: TextStyle(
                    color: darkMode
                        ? AppConstants.subTextColorDark
                        : AppConstants.subTextColor)),
          ],
        ),
        Divider(color: Colors.teal[300]),
      ],
    );
  }
}
