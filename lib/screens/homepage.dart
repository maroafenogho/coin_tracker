import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Text('Welcome to Coin tracker'),
            ElevatedButton(
              onPressed: () {},
              child: Text('Continue'),
            ),
          ],
        )),
      ),
    );
  }
}
