import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';
import '../../../core/helper/navigation_extentions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/shared/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                      verticalSpace(20),
                      CustomAuthButton(
                        backGroundColor: AppColors.primary,
                        foreGroundColor: AppColors.white,
                        text: 'Login',
                        onpressed: () {},
                      ),
                      verticalSpace(20),
                      CustomAuthButton(
                        text: 'Sign Up',
                        onpressed: () {
                          context.pushNamed(AppRoutes.signUp);
                        },
                      ),
                      verticalSpace(10),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoutes.bottomNaviBar);
                        },
                        child: Text('Continue as a guest ?',
                            style: TextStyles.textStyle14.copyWith(
                              color: AppColors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
