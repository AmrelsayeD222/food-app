import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';
import '../../../core/helper/navigation_extentions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/helper/text_style.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/shared/custom_text_form_field.dart';
import '../manager/login_cubit/loign_cubit.dart';
import '../manager/login_cubit/loign_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          log(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoginSuccess) {
          final token = state.loginModel.data?.token;
          if (token != null && token.isNotEmpty) {
            // Clear previous user's data
            final cartCubit = getIt<CartCubitCubit>();
            cartCubit.clearCart();

            final profileCubit = getIt<GetProfileDataCubit>();
            profileCubit.clearProfile(); // Clear previous profile data
            profileCubit.getProfileData(token: token, forceRefresh: true);

            if (!context.mounted) return;
            context.pushReplacementNamed(AppRoutes.bottomNaviBar);
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    /// ================= HEADER =================
                    SliverAppBar(
                      expandedHeight: 250,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                    SliverToBoxAdapter(
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
                                    value == null || value.isEmpty
                                        ? 'Enter your Email'
                                        : null,
                              ),
                              verticalSpace(10),
                              CustomTextFormField(
                                controller: cubit.loginPasswordController,
                                hintText: 'Password',
                                obscureText: cubit.loginIsObscure,
                                enabled: !isLoading,
                                suffixIcon: IconButton(
                                  onPressed: isLoading
                                      ? null
                                      : cubit.togglePasswordVisibility,
                                  icon: Icon(
                                    cubit.loginIsObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
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
                                    onpressed: isLoading
                                        ? null
                                        : cubit.validateAndLogin,
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                            color: AppColors.white,
                                            strokeWidth: 3,
                                          )
                                        : const Text(
                                            'Login',
                                            style: TextStyle(
                                                color: AppColors.white),
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
                                                  context.pushNamed(
                                                      AppRoutes.signUp);
                                                },
                                          child: const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                color: AppColors.primary),
                                          ),
                                        ),
                                      ),
                                      horizontalSpace(10),
                                      Expanded(
                                        child: CustomAuthButton(
                                          backGroundColor: AppColors.white,
                                          foreGroundColor: AppColors.primary,
                                          onpressed: isLoading
                                              ? null
                                              : () {
                                                  context.pushReplacementNamed(
                                                      AppRoutes.bottomNaviBar);
                                                },
                                          child: const Text(
                                            'Guest',
                                            style: TextStyle(
                                                color: AppColors.primary),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
