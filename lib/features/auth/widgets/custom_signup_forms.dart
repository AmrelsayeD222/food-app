import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/core/shared/custom_text_form_field.dart';
import 'package:foods_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';

class CustomSignUpforms extends StatelessWidget {
  const CustomSignUpforms({
    super.key,
    required this.cubit,
    required this.isLoading,
  });

  final SignUpCubit cubit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Form(
        key: cubit.signUpFormKey,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpace(10.h),
              CustomTextFormField(
                controller: cubit.nameController,
                hintText: 'Your Name',
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              verticalSpace(10.h),
              CustomTextFormField(
                controller: cubit.addressController,
                hintText: 'Address',
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your address';
                  }
                  if (value.trim().length < 3) {
                    return 'Address must be at least 3 characters';
                  }
                  return null;
                },
              ),
              verticalSpace(10.h),
              CustomTextFormField(
                controller: cubit.signUpEmailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email Address',
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your Email';
                  }
                  // Email validation using RegEx
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              verticalSpace(10.h),
              CustomTextFormField(
                controller: cubit.signUpPasswordController,
                hintText: 'Password',
                enabled: !isLoading,
                obscureText: cubit.signUpIsObscure,
                suffixIcon: IconButton(
                  onPressed:
                      isLoading ? null : cubit.signUpTogglePasswordVisibility,
                  icon: Icon(
                    cubit.signUpIsObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              verticalSpace(20.h),
              Column(
                children: [
                  CustomAuthButton(
                    width: double.infinity,
                    onpressed: isLoading ? null : cubit.validateAndSign,
                    backGroundColor: AppColors.primary,
                    foreGroundColor: AppColors.white,
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 3.w,
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(color: AppColors.white),
                          ),
                  ),
                  verticalSpace(10.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomAuthButton(
                          onpressed: isLoading
                              ? null
                              : () {
                                  context.pushNamed(AppRoutes.login);
                                },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                      horizontalSpace(10.w),
                      Expanded(
                        child: CustomAuthButton(
                          onpressed: isLoading ? null : cubit.signUpAsGuest,
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
