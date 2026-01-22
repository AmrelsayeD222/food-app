import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_image.dart';
import 'package:foods_app/features/auth/widgets/guest_profile.dart';
import 'package:foods_app/features/auth/widgets/profile_card_info.dart';
import 'package:foods_app/features/auth/widgets/profile_dialog.dart';
import 'package:foods_app/features/auth/widgets/update_profile_image_bottom.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  GetProfileDataModel _getDummyProfile() {
    return GetProfileDataModel(
      name: 'John Doe',
      email: 'john.doe@example.com',
      image: 'https://via.placeholder.com/150',
      address: '123 Main St, New York, NY 10001',
      visa: '4242 **** **** 4242',
    );
  }

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
                    scrolledUnderElevation: 0,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
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
      return Skeletonizer(
        enabled: true,
        child: _buildProfileContent(context, _getDummyProfile()),
      );
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gradient Header Section
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  // Profile Image
                  CustomProfileImage(imageUrl: profile.image),
                  verticalSpace(16.h),

                  // Update Image Button
                  buildUpdateImageButton(context, profile),
                ],
              ),
            ),

            verticalSpace(20.h),

            // Profile Information Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Information',
                    style: TextStyles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  verticalSpace(12.h),

                  // Name Card
                  buildInfoCard(
                    icon: Icons.person_outline,
                    label: 'Name',
                    value: profile.name ?? 'N/A',
                  ),
                  verticalSpace(12.h),

                  // Email Card
                  buildInfoCard(
                    icon: Icons.email_outlined,
                    label: 'Email Address',
                    value: profile.email ?? 'N/A',
                  ),
                  verticalSpace(12.h),

                  // Address Card
                  buildInfoCard(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: profile.address ?? 'No address provided',
                  ),
                  verticalSpace(100.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
