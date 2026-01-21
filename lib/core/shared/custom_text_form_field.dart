import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.fillColor,
    this.label,
    this.enabled,
    this.keyboardType,
    this.onChanged,
  });
  final String? hintText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  final Widget? prefixIcon;
  final Color? fillColor;
  final String? label;
  final bool? enabled;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: onChanged,
      cursorHeight: 20,
      controller: controller,
      obscureText: obscureText ?? false,
      cursorColor: AppColors.primary,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.grey),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyLight),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        hintText: hintText,
        fillColor: fillColor ?? AppColors.white,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabled: enabled ?? true,
      ),
    );
  }
}
