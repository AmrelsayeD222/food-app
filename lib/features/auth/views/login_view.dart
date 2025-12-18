import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';
import '../../../core/helper/navigation_extentions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/shared/custom_text_form_field.dart';
import '../manager/login_cubit/loign_cubit.dart';
import '../manager/login_cubit/loign_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          log(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is LoginLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Loading...')),
          );
        } else if (state is LoginSuccess) {
          context.pushReplacementNamed(AppRoutes.bottomNaviBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    verticalSpace(200),
                    SvgPicture.asset(
                      'assets/splash/splash_logo.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
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
                            controller: cubit.emailController,
                            hintText: 'Email Address',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your Email';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            controller: cubit.passwordController,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: Icon(
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: 'Password',
                            obscureText: isObscure,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(20),

                          /// Login Button (fixed)
                          CustomAuthButton(
                            backGroundColor: AppColors.primary,
                            foreGroundColor: AppColors.white,
                            text:
                                state is LoginLoading ? 'Loading...' : 'Login',
                            onpressed: () {
                              if (state is! LoginLoading) {
                                cubit.validateAndLogin();
                              }
                            },
                          ),
                          verticalSpace(10),
                          CustomAuthButton(
                            backGroundColor: AppColors.white,
                            foreGroundColor: AppColors.primary,
                            text: 'Sign Up',
                            onpressed: () {},
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.bottomNaviBar);
                            },
                            child: Text(
                              'Continue as a guest ?',
                              style: TextStyles.textStyle14.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
