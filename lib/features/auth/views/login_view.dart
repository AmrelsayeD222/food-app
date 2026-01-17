import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_appbar.dart';
import 'package:foods_app/features/auth/widgets/custom_login_forms.dart';
import '../../../core/helper/navigation_extentions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../manager/login_cubit/login_cubit.dart';
import '../manager/login_cubit/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
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
            cubit.clearPreviousData();

            // Get fresh profile data
            final profileCubit = getIt<GetProfileDataCubit>();
            profileCubit.getProfileData(forceRefresh: true);

            if (!context.mounted) return;
            context.pushReplacementNamed(AppRoutes.bottomNaviBar);
          }
        } else if (state is GuestModeSuccess) {
          if (!context.mounted) return;
          context.pushReplacementNamed(AppRoutes.bottomNaviBar);
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
                    const CustomAuthAppBar(),
                    CustomLoginForms(cubit: cubit, isLoading: isLoading),
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
