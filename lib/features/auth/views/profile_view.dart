import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_bottom.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_image.dart';
import 'package:foods_app/features/auth/widgets/profile_visa_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: [
          const Icon(Icons.settings, color: Colors.black),
          horizontalSpace(10),
        ],
      ),
      bottomSheet: _buildBottomSheet(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
          builder: (context, state) {
            if (state is GetProfileDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetProfileDataFailure) {
              return Center(child: Text(state.error));
            } else if (state is GetProfileDataEmpty) {
              return Center(child: Text(state.noTokenMessage));
            } else if (state is GetProfileDataSuccess) {
              final profile = state.profileData;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: CustomProfileImage(imageUrl: profile.image)),
                  verticalSpace(20),
                  Text('Name : ${profile.name}', style: TextStyles.textStyle18),
                  verticalSpace(20),
                  Text('Email :${profile.email}',
                      style: TextStyles.textStyle18),
                  verticalSpace(20),
                  Text('Address :${profile.address}',
                      style: TextStyles.textStyle18),
                  verticalSpace(20),
                  ProfileVisaTile(visa: profile.visa),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        return Container(
          height: 100,
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomProfileBottom(
                text: 'Edit Profile',
                backColor: AppColors.primary,
                foreColor: AppColors.white,
                icon: Icons.edit,
                onpressed: () {
                  // Navigate to edit profile screen
                },
              ),
              CustomProfileBottom(
                text: 'Log out',
                backColor: AppColors.white,
                foreColor: AppColors.primary,
                icon: Icons.logout,
                onpressed: () async {
                  await getIt<SharedPrefsService>().clearToken();
                  // ignore: use_build_context_synchronously
                  context.read<GetProfileDataCubit>().logout();
                  if (!context.mounted) return;
                  context.pushReplacementNamed(AppRoutes.signUp);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
