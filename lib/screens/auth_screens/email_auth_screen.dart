import 'package:coin_tracker/screens/auth_screens/login.dart';
import 'package:coin_tracker/widgets/edittext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tools/auth_service.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  String email = '', password = '', confirmPassword = '', displayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: GetBuilder<AuthController>(
              builder: (_) => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Email address:'),
                    EditText(
                      onChanged: (typedText) {
                        email = typedText;
                      },
                      obscureText: false,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text('Username:'),
                    EditText(
                      onChanged: (typedText) {
                        displayName = typedText;
                      },
                      obscureText: false,
                      inputType: TextInputType.name,
                    ),
                    const Text('Password:'),
                    EditText(
                      onChanged: (typedText) {
                        if (typedText.length >= 6 || typedText.isEmpty) {
                          authController.hideWarning();
                        } else {
                          authController.showWarning();
                        }

                        password = typedText;
                      },
                      obscureText: true,
                      inputType: TextInputType.none,
                    ),
                    authController.warningLength == ''
                        ? Container()
                        : Text(
                            authController.warningLength,
                            style: const TextStyle(color: Colors.red),
                          ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text('Confirm Password:'),
                    EditText(
                      onChanged: (typedText) {
                        confirmPassword = typedText;
                        password == confirmPassword
                            ? authController.hideWarningDifferent()
                            : authController.showWarningDifferent();
                      },
                      obscureText: true,
                      inputType: TextInputType.none,
                    ),
                    authController.warningDifferent == ''
                        ? Container()
                        : Text(
                            authController.warningDifferent,
                            style: const TextStyle(color: Colors.red),
                          ),
                    ElevatedButton(
                      onPressed: () {
                        authController.createUser(email, password, displayName);
                        authController.loading();
                      },
                      child: authController.isLoading == false
                          ? const Text('Register')
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() =>  Login());
                      },
                      child: const Text('Go to Login page'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
