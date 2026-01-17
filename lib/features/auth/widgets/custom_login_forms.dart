import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/core/shared/custom_text_form_field.dart';
import 'package:foods_app/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';

class CustomLoginForms extends StatelessWidget {
  const CustomLoginForms({
    super.key,
    required this.cubit,
    required this.isLoading,
  });

  final LoginCubit cubit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Form(
        key: cubit.loginFormKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpace(10),
              CustomTextFormField(
                controller: cubit.loginEmailController,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your Email' : null,
              ),
              verticalSpace(10),
              CustomTextFormField(
                controller: cubit.loginPasswordController,
                hintText: 'Password',
                obscureText: cubit.loginIsObscure,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  onPressed: isLoading ? null : cubit.togglePasswordVisibility,
                  icon: Icon(
                    cubit.loginIsObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your password'
                    : null,
              ),
              verticalSpace(20),
              Column(
                children: [
                  CustomAuthButton(
                    width: double.infinity,
                    backGroundColor: AppColors.primary,
                    foreGroundColor: AppColors.white,
                    onpressed: isLoading ? null : cubit.validateAndLogin,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 3,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(color: AppColors.white),
                          ),
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomAuthButton(
                          backGroundColor: AppColors.white,
                          foreGroundColor: AppColors.primary,
                          onpressed: isLoading
                              ? null
                              : () {
                                  context.pushNamed(AppRoutes.signUp);
                                },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: CustomAuthButton(
                          backGroundColor: AppColors.white,
                          foreGroundColor: AppColors.primary,
                          onpressed: isLoading ? null : cubit.loginAsGuest,
                          child: const Text(
                            'Guest',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
