import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    super.key,
    required this.controller,
    required this.formFieldValidator,
    required this.prefixIcon,
    this.suffixIcon,
    this.isfilled,
    this.isobscureText = false,
    this.textInputType,
    this.labelText,
  });

  final TextEditingController controller;
  final FormFieldValidator formFieldValidator;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool? isfilled;
  final bool isobscureText;
  final TextInputType? textInputType;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: isobscureText,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: prefixIcon,
        labelText: labelText,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        filled: true,
      ),
      controller: controller,
      validator: formFieldValidator,
    );
  }
}
