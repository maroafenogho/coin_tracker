import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  const EditText({Key? key, required this.onChanged, required this.obscureText, required this.inputType})
      : super(key: key);
  final Function(String) onChanged;
  final bool obscureText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      keyboardType: inputType,
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
