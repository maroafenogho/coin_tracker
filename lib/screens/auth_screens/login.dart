import 'package:coin_tracker/screens/auth_screens/email_auth_screen.dart';
import 'package:coin_tracker/tools/auth_service.dart';
import 'package:coin_tracker/widgets/edittext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final getxController = Get.put(Controller());
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GetBuilder<Controller>(
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
                    getxController.loading();
                    getxController.signIn(email, password).then((user) {
                      getxController.loading();
                      if (user!.emailVerified!) {
                        Get.snackbar(
                          'Login successful',
                          'User authenticated with ${user.email} successfully',
                          duration: const Duration(seconds: 5),
                        );
                      } else {
                        getxController.signOut();
                        Get.snackbar(
                          'Login Unuccessful',
                          'Email Address not verified',
                          duration: const Duration(seconds: 5),
                        );
                      }
                    });
                  },
                  child: getxController.isLoading == false
                      ? const Text('Login')
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUp());
                  },
                  child: Text('Go to Registration page'),
                ),
                TextButton(
                  onPressed: () {
                    getxController.signOut();
                  },
                  child: Text('logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
