import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/auth/data/repo/repo.dart';
import 'package:foods_app/features/auth/data/repo/repo_impl.dart';
import 'package:foods_app/features/auth/manager/Update_profile/update_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/profile_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_bottom.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_data.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_image.dart';
import 'package:foods_app/features/auth/widgets/profile_visa_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final Repo repo;
  late final GetProfileDataCubit getCubit;
  late final UpdateProfileDataCubit updateCubit;

  @override
  void initState() {
    super.initState();
    repo = RepoImpl(AppRoutes.apiServices, AppRoutes.prefsService);

    getCubit = GetProfileDataCubit(repo);
    updateCubit = UpdateProfileDataCubit(repo);

    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final token = await AppRoutes.prefsService.getToken();
    if (!getCubit.isClosed && token != null && token.isNotEmpty) {
      await getCubit.getProfileData(token: token);
    }
  }

  @override
  void dispose() {
    getCubit.close();
    updateCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getCubit),
        BlocProvider.value(value: updateCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          actions: [
            const Icon(Icons.settings, color: Colors.black),
            horizontalSpace(10)
          ],
        ),
        bottomSheet: _buildBottomSheet(),
        body: BlocListener<UpdateProfileDataCubit, UpdateProfileDataState>(
          bloc: updateCubit,
          listener: (context, state) async {
            if (state is UpdateProfileDataSuccess) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              await _fetchProfile(); // جلب البيانات بعد التحديث
            } else if (state is UpdateProfileDataFailure) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.errMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
            bloc: getCubit,
            builder: (context, state) {
              if (state is GetProfileDataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetProfileDataFailure) {
                return Center(child: Text(state.failure.errMessage));
              } else if (state is GetProfileDataSuccess) {
                final data = state.data.data;
                // تعبئة الـ controllers فقط إذا كانت فارغة
                if (getCubit.profileNameController.text.isEmpty) {
                  getCubit.profileNameController.text = data?.name ?? '';
                }
                if (getCubit.profileEmailController.text.isEmpty) {
                  getCubit.profileEmailController.text = data?.email ?? '';
                }
                if (getCubit.profileAddressController.text.isEmpty) {
                  getCubit.profileAddressController.text = data?.address ?? '';
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomProfileImage(imageUrl: data?.image),
                      CustomProfiledata(
                        profileNameController: getCubit.profileNameController,
                        profileEmailController: getCubit.profileEmailController,
                        profileAddressController:
                            getCubit.profileAddressController,
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
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
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
            onpressed: () async {
              final token = await AppRoutes.prefsService.getToken();
              if (!updateCubit.isClosed && token != null && token.isNotEmpty) {
                await updateCubit.updateProfile(token: token);
              }
            },
          ),
          const CustomProfileBottom(
            text: 'Log out',
            backColor: AppColors.white,
            foreColor: AppColors.primary,
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
