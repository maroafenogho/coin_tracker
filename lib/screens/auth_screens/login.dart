import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Email address:'),
              TextFormField(
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                onChanged: (typedText) {},
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text('Password:'),
              TextFormField(
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                onChanged: (typedText) {},
              ),
              const SizedBox(
                height: 8.0,
              ),
              
              ElevatedButton(
               onPressed: (){},
               child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
