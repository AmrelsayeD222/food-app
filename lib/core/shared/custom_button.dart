import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.text,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
      child: Text(
        text,
      ),
    );
  }
}
