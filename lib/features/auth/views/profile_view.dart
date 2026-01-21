import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_image.dart';
import 'package:foods_app/features/auth/widgets/guest_profile.dart';
import 'package:foods_app/features/auth/widgets/profile_dialog.dart';
import 'package:foods_app/features/auth/widgets/profile_skeleton.dart';
import 'package:foods_app/features/auth/widgets/profile_visa_tile.dart';
import 'package:foods_app/features/auth/widgets/update_profile_image_bottom.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetProfileDataCubit, GetProfileDataState>(
      listener: (context, state) {
        // Handle logout success
        if (state is LogoutSuccess) {
          if (!context.mounted) return;
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
            AppRoutes.signUp,
            (route) => false,
          );
        }

        // Handle logout failure
        if (state is GetProfileDataFailure &&
            state.error.contains('Logout failed')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
        builder: (context, state) {
          return Scaffold(
            appBar: state is GetProfileDataEmpty
                ? null
                : AppBar(
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        onPressed: () => showLogoutDialog(context),
                        icon: const Icon(Icons.logout, color: Colors.black),
                      ),
                      horizontalSpace(10),
                    ],
                  ),
            body: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, GetProfileDataState state) {
    if (state is GetProfileDataLoading || state is LogoutLoading) {
      return const ProfileSkeleton();
    }

    if (state is GetProfileDataFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.error),
            verticalSpace(20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              onPressed: () {
                context.read<GetProfileDataCubit>().getProfileData(
                      forceRefresh: true,
                    );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is GetProfileDataEmpty) {
      return const Center(child: GuestProfile());
    }

    if (state is GetProfileDataSuccess) {
      return _buildProfileContent(context, state.profileData);
    }

    return const SizedBox();
  }

  Widget _buildProfileContent(
      BuildContext context, GetProfileDataModel profile) {
    return RefreshIndicator(
      backgroundColor: AppColors.white,
      color: AppColors.primary,
      onRefresh: () async {
        await context
            .read<GetProfileDataCubit>()
            .getProfileData(forceRefresh: true);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: CustomProfileImage(imageUrl: profile.image),
            ),
            verticalSpace(20.h),

            // Update Image Button
            buildUpdateImageButton(context, profile),
            verticalSpace(30.h),

            // Profile Information
            Text('Name: ${profile.name ?? 'N/A'}',
                style: TextStyles.textStyle18),
            verticalSpace(20.h),
            Text('Email: ${profile.email ?? 'N/A'}',
                style: TextStyles.textStyle18),
            verticalSpace(20.h),
            Text('Address: ${profile.address ?? 'No address provided'}',
                style: TextStyles.textStyle18),
            verticalSpace(20.h),
            ProfileVisaTile(visa: profile.visa ?? '**** **** **** ****'),
            verticalSpace(20.h),
          ],
        ),
      ),
    );
  }
}
