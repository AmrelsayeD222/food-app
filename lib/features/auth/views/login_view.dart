import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_app/core/helper/spacing.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/shared/custom_button.dart';
import '../../../core/shared/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(100),
                SvgPicture.asset('assets/splash/splash_logo.svg'),
                verticalSpace(10),
                const Text(
                  'Welcome Back,Discover The Fast Food',
                  style: TextStyles.textStyle13,
                ),
                verticalSpace(70),
                CustomTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    hintText: 'Email Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    }),
                verticalSpace(20),
                CustomTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: isObscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: 'Password',
                    obscureText: isObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    }),
                verticalSpace(50),
                CustomButton(text: 'Login', formKey: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
