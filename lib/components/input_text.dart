import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.enable = true,
    this.autoFocus = false,
    required this.controller,
    required this.validator,
    required this.keyBoardType,
    required this.hint,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;

  // final FocusNode focusNode;
  // final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator validator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;
  final Widget prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      autofocus: autoFocus,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      controller: controller,
      validator: validator,
      style: fEncodeSansMedium.copyWith(fontSize: smallFontSize),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: COLORS.dark),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: COLORS.dark),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: COLORS.grey),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }
}
