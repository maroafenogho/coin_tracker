import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  const EditText({Key? key, required this.onChanged, required this.obscureText}) : super(key: key);
  final Function(String) onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      obscureText: obscureText,
      
    );
  }
}
