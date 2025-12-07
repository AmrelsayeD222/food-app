import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/shared/custom_button.dart';
import '../../../core/shared/custom_text_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController confirmPassController;
  late TextEditingController nameController;
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

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
                verticalSpace(50),
                CustomTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    hintText: 'Your Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    }),
                verticalSpace(20),
                CustomTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    hintText: 'Email Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Email';
                      }
                      return null;
                    }),
                verticalSpace(20),
                CustomTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passController,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordObscure = !isPasswordObscure;
                          });
                        },
                        child: isPasswordObscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: 'Password',
                    obscureText: isPasswordObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    }),
                verticalSpace(20),
                CustomTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmPassController,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isConfirmPasswordObscure =
                                !isConfirmPasswordObscure;
                          });
                        },
                        child: isConfirmPasswordObscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: 'Confirm Password',
                    obscureText: isConfirmPasswordObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password confirmation';
                      }
                      return null;
                    }),
                verticalSpace(50),
                CustomButton(text: 'Sign Up', formKey: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
