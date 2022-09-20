import 'package:coin_tracker/app/modules/auth/notifiers/auth_state.dart';
import 'package:coin_tracker/app/modules/auth/notifiers/user_notifier.dart';
import 'package:coin_tracker/app/modules/coins/screens/coins_list_page.dart';
import 'package:coin_tracker/app/modules/home/screens/dashboard.dart';
import 'package:coin_tracker/views/auth_screens/email_auth_screen.dart';
import 'package:coin_tracker/services/auth_service.dart';
import 'package:coin_tracker/views/widgets/edittext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class LoginRiv extends StatelessWidget {
  LoginRiv({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final authState = ref.watch(authNotifierProvider);
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Email address:'),
                EditText(
                  onChanged: (typedText) {
                    ref.read(emailProvider.state).state = typedText;
                  },
                  obscureText: false,
                  inputType: TextInputType.name,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text('Password:'),
                EditText(
                  onChanged: (typedText) {
                    ref.read(passwordProvider.state).state = typedText;
                  },
                  obscureText: true,
                  inputType: TextInputType.name,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).login(
                        email: emailController.text,
                        password: passwordController.text);

                    if (authState.status == AuthStatus.success) {
                      Get.to(() => Dashboard());
                    }

                    // final login = ref.watch(firebaseLoginProvider);
                    // login.when(data: (user) {
                    //   ref.read(authLoadingStateProvider.state).state = false;
                    //   if (user != null) {
                    //     if (user.emailVerified!) {
                    //     } else {
                    //       Get.snackbar(
                    //         'Login Unuccessful',
                    //         'Email Address not verified',
                    //         duration: const Duration(seconds: 5),
                    //       );
                    //     }
                    //   }
                    // }, error: (error, stacktrace) {
                    //   ref.read(authLoadingStateProvider.state).state = false;
                    // }, loading: () {
                    //   ref.read(authLoadingStateProvider.state).state = true;
                    // });
                  },
                  child:
                      // ref.watch(authLoadingStateProvider.notifier).state == true
                      //     ? const CircularProgressIndicator(
                      //         color: Colors.white,
                      //       )
                      //     : const Text('Login'),

                      authState.status == AuthStatus.initial
                          ? const Text('Login')
                          : authState.status == AuthStatus.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : authState.status == AuthStatus.success
                                  ? const Text('Login')
                                  : const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUp());
                  },
                  child: const Text('Go to Registration page'),
                ),
                TextButton(
                  onPressed: () {
                    authController.signOut();
                  },
                  child: const Text('logout'),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
