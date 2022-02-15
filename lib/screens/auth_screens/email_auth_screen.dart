import 'package:coin_tracker/screens/auth_screens/login.dart';
import 'package:coin_tracker/widgets/edittext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tools/auth_service.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final getxController = Get.put(Controller());
  String email = '', password = '', confirmPassword = '', displayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: GetBuilder<Controller>(
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
                          getxController.hideWarning();
                        } else {
                          getxController.showWarning();
                        }

                        password = typedText;
                      },
                      obscureText: true,
                      inputType: TextInputType.none,
                    ),
                    getxController.warningLength == ''
                        ? Container()
                        : Text(
                            getxController.warningLength,
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
                            ? getxController.hideWarningDifferent()
                            : getxController.showWarningDifferent();
                      },
                      obscureText: true,
                      inputType: TextInputType.none,
                    ),
                    getxController.warningDifferent == ''
                        ? Container()
                        : Text(
                            getxController.warningDifferent,
                            style: const TextStyle(color: Colors.red),
                          ),
                    ElevatedButton(
                      onPressed: () {
                        getxController.createUser(email, password, displayName);
                        getxController.loading();
                      },
                      child: getxController.isLoading == false
                          ? const Text('Register')
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() =>  Login());
                      },
                      child: Text('Go to Login page'),
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
