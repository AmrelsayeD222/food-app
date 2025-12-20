import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/routes/app_routes.dart';

import '../widgets/custom_auth_button.dart';
import '../../../core/shared/custom_text_form_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is SignUpSuccess) {
          context.pushReplacementNamed(AppRoutes.bottomNaviBar);
          cubit.signClearFields();
        }
      },
      builder: (context, state) {
        final isLoading = state is SignUpLoading;

        return Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                /// ================= HEADER =================
                SliverAppBar(
                  pinned: false,
                  floating: false,
                  expandedHeight: 350,
                  backgroundColor: AppColors.white,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/splash/splash_logo.svg',
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        verticalSpace(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Welcome Back, Discover The Fast Food',
                            style: TextStyles.textStyle13.copyWith(
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// ================= FORM =================
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    key: cubit.signUpFormKey,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          verticalSpace(10),
                          CustomTextFormField(
                            controller: cubit.nameController,
                            hintText: 'Your Name',
                            enabled: !isLoading,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter your name'
                                : null,
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            controller: cubit.signUpEmailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email Address',
                            enabled: !isLoading,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter your Email'
                                : null,
                          ),
                          verticalSpace(20),
                          CustomTextFormField(
                            controller: cubit.signUpPasswordController,
                            hintText: 'Password',
                            enabled: !isLoading,
                            obscureText: cubit.signUpIsObscure,
                            suffixIcon: IconButton(
                              onPressed: isLoading
                                  ? null
                                  : cubit.signUpTogglePasswordVisibility,
                              icon: Icon(
                                cubit.signUpIsObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter your password'
                                : null,
                          ),
                          verticalSpace(30),
                          CustomAuthButton(
                            onpressed: isLoading ? null : cubit.validateAndSign,
                            backGroundColor: AppColors.primary,
                            foreGroundColor: AppColors.white,
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 3,
                                  )
                                : const Text(
                                    'Sign Up',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                          ),
                          verticalSpace(20),
                          CustomAuthButton(
                            onpressed: () {
                              context.pushNamed(AppRoutes.login);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                          verticalSpace(10),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.pushReplacementNamed(
                                        AppRoutes.bottomNaviBar);
                                  },
                            child: Text(
                              'Continue as a guest?',
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
