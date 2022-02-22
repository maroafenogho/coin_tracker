import 'package:coin_tracker/views/auth_screens/email_auth_screen.dart';
import 'package:coin_tracker/views/home.dart';
import 'package:coin_tracker/services/auth_service.dart';
import 'package:coin_tracker/views/widgets/edittext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GetBuilder<AuthController>(
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Email address:'),
                EditText(
                  onChanged: (typedText) {
                    email = typedText;
                  },
                  obscureText: false,
                  inputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text('Password:'),
                EditText(
                  onChanged: (typedText) {
                    password = typedText;
                  },
                  obscureText: true,
                  inputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    authController.loading();
                    authController.signIn(email, password).then((user) {
                      authController.loading();
                      if (user!.emailVerified!) {
                        Get.to(() => HomeScreen());
                        Get.snackbar(
                          'Login successful',
                          'User authenticated with ${user.email} successfully',
                          duration: const Duration(seconds: 5),
                        );
                      } else {
                        authController.signOut();
                        Get.snackbar(
                          'Login Unuccessful',
                          'Email Address not verified',
                          duration: const Duration(seconds: 5),
                        );
                      }
                    }).onError((error, stackTrace) {
                      authController.loading();
                      Get.snackbar(
                          'Error',
                          '$error ',
                          duration: const Duration(seconds: 5),
                        );
                    });
                  },
                  child: authController.isLoading == false
                      ? const Text('Login')
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
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
          ),
        ),
      ),
    );
  }
}
