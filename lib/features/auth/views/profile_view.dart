import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/auth/data/repo/repo_impl.dart';
import 'package:foods_app/features/auth/manager/profile_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_bottom.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_data.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_image.dart';
import 'package:foods_app/features/auth/widgets/profile_visa_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = GetProfileDataCubit(
          RepoImpl(AppRoutes.apiServices, AppRoutes.prefsService),
        );

        // load profile after cubit is created
        AppRoutes.prefsService.getToken().then((token) {
          if (token != null && token.isNotEmpty) {
            if (!cubit.isClosed) {
              cubit.getProfileData(token: token);
            }
          } else {
            debugPrint('❌ TOKEN IS NULL');
          }
        });

        return cubit;
      },
      child: Builder(builder: (context) {
        final cubit = context.read<GetProfileDataCubit>();

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: const Icon(Icons.arrow_back, color: Colors.black),
            actions: [
              const Icon(Icons.settings, color: Colors.black),
              horizontalSpace(10)
            ],
          ),
          bottomSheet: Container(
            height: 100,
            color: AppColors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomProfileBottom(
                  text: 'Edit Profile',
                  backColor: AppColors.primary,
                  foreColor: AppColors.white,
                  icon: Icons.edit,
                ),
                CustomProfileBottom(
                  text: 'Log out',
                  backColor: AppColors.white,
                  foreColor: AppColors.primary,
                  icon: Icons.logout,
                )
              ],
            ),
          ),
          body: BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
            builder: (context, state) {
              if (state is GetProfileDataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetProfileDataFailure) {
                return Center(child: Text(state.failure.errMessage));
              } else if (state is GetProfileDataSuccess) {
                final data = state.data.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomProfileImage(imageUrl: data?.image),
                      CustomProfiledata(
                        profileNameController: cubit.profileNameController,
                        profileEmailController: cubit.profileEmailController,
                        profileAddressController:
                            cubit.profileAddressController,
                      ),
                      ProfileVisaTile(visa: data?.visa),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      }),
    );
  }
}
