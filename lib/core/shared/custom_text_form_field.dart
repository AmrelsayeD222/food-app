import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.autovalidateMode,
  });
  final String hintText;
  final bool? obscureText;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
      cursorHeight: 20,
      controller: controller,
      obscureText: obscureText ?? false,
      cursorColor: AppColors.primary,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
