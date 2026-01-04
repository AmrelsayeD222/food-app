import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/core/helper/navigation_extentions.dart';
import 'package:foods_app/core/helper/shared_pref_storage.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/helper/text_style.dart';
import 'package:foods_app/core/routes/app_routes.dart';

import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/Post_profile_data_cubit.dart/post_profile_data_cubit.dart';

import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';
import 'package:foods_app/features/auth/widgets/custom_profile_image.dart';
import 'package:foods_app/features/auth/widgets/profile_visa_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<String> _getToken() async {
    return await getIt<SharedPrefsService>().getToken() ?? '';
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel",
                  style: TextStyle(color: AppColors.black)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: AppColors.white),
              ),
            )
          ],
        );
      },
    );

    if (confirmed != true) return;

    await getIt<SharedPrefsService>().clearToken();
    if (!context.mounted) return;

    context.read<GetProfileDataCubit>().logout();
    context.pushReplacementNamed(AppRoutes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
          horizontalSpace(10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
          builder: (context, state) {
            if (state is GetProfileDataLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetProfileDataFailure) {
              return Center(child: Text(state.error));
            }

            if (state is GetProfileDataEmpty) {
              return Center(child: Text(state.noTokenMessage));
            }

            if (state is GetProfileDataSuccess) {
              final profile = state.profileData;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomProfileImage(
                      imageUrl: profile.image,
                    ),
                  ),

                  verticalSpace(20),

                  /// 🔥 UPDATE IMAGE BUTTON
                  BlocConsumer<PostProfileDataCubit, PostProfileDataState>(
                    listener: (context, uploadState) {
                      if (uploadState is PostProfileDataSuccess) {
                        final data = uploadState.response.data;

                        context
                            .read<GetProfileDataCubit>()
                            .updateProfileFromUpload(
                              name: data.name ?? profile.name ?? '',
                              email: data.email ?? profile.email ?? '',
                              address: data.address ?? profile.address ?? '',
                              image: data.image ?? profile.image ?? '',
                              visa: data.visa ?? profile.visa ?? '',
                            );
                      }

                      if (uploadState is PostProfileDataFailure) {
                        log(uploadState.errorMessage);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(uploadState.errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, uploadState) {
                      final isLoading = uploadState is PostProfileDataLoading;

                      return Center(
                        child: CustomAuthButton(
                          backGroundColor: AppColors.primary,
                          foreGroundColor: AppColors.white,
                          onpressed: isLoading
                              ? null
                              : () async {
                                  final picker = ImagePicker();
                                  final picked = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );

                                  if (picked == null) return;

                                  final token = await _getToken();

                                  if (token.isEmpty) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("You are not logged in"),
                                      ),
                                    );
                                    return;
                                  }

                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<PostProfileDataCubit>()
                                      .postProfileData(
                                        token: token,
                                        imagePath: picked.path,
                                        name: profile.name,
                                      );
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Update Image"),
                        ),
                      );
                    },
                  ),

                  verticalSpace(30),
                  Text('Name : ${profile.name}', style: TextStyles.textStyle18),
                  verticalSpace(20),
                  Text('Email : ${profile.email}',
                      style: TextStyles.textStyle18),
                  verticalSpace(20),
                  Text('Address : ${profile.address}',
                      style: TextStyles.textStyle18),
                  verticalSpace(20),

                  ProfileVisaTile(visa: profile.visa),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
