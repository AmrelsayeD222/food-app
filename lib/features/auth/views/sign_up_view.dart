import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/routes/app_routes.dart';

import '../widgets/custom_auth_button.dart';
import '../../../core/shared/custom_text_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController emailController;
  late TextEditingController passController;

  late TextEditingController nameController;
  bool isPasswordObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                verticalSpace(200),
                SvgPicture.asset('assets/splash/splash_logo.svg',
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn)),
                verticalSpace(10),
                Text(
                  'Welcome Back,Discover The Fast Food',
                  style: TextStyles.textStyle13.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                verticalSpace(110),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(50),
                      CustomTextFormField(
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
                      CustomAuthButton(
                        backGroundColor: AppColors.primary,
                        foreGroundColor: AppColors.white,
                        text: 'Sign Up',
                        onpressed: () {},
                      ),
                      verticalSpace(20),
                      CustomAuthButton(
                        text: 'Login',
                        onpressed: () {
                          context.pushNamed(AppRoutes.login);
                        },
                      ),
                      verticalSpace(10),
                      Text('already have an account ?',
                          style: TextStyles.textStyle14.copyWith(
                            color: AppColors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
