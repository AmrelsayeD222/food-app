import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_appbar.dart';
import 'package:foods_app/features/auth/widgets/custom_signup_forms.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

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
          final token = state.signUpModel.data?.token;
          if (token != null && token.isNotEmpty) {
            // Get fresh profile data
            final profileCubit = getIt<GetProfileDataCubit>();
            profileCubit.getProfileData(forceRefresh: true);

            if (!context.mounted) return;
            context.pushReplacementNamed(AppRoutes.bottomNaviBar);
          }
        } else if (state is SignUpGuestModeSuccess) {
          if (!context.mounted) return;
          context.pushReplacementNamed(AppRoutes.bottomNaviBar);
        }
      },
      builder: (context, state) {
        final isLoading = state is SignUpLoading;

        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    /// ================= HEADER =================
                    const CustomAuthAppBar(),

                    /// ================= FORM =================
                    CustomSignUpforms(cubit: cubit, isLoading: isLoading),
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
