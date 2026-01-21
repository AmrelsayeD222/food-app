import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/manager/post_profile_data_cubit/post_profile_data_cubit.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:foods_app/features/auth/widgets/custom_auth_button.dart';
import 'package:foods_app/features/auth/widgets/upload_profile_image.dart';

Widget buildUpdateImageButton(
    BuildContext context, GetProfileDataModel profile) {
  return BlocConsumer<PostProfileDataCubit, PostProfileDataState>(
    listener: (context, uploadState) {
      if (uploadState is PostProfileDataSuccess) {
        final data = uploadState.response.data;

        final newImageUrl = (data.image != null && data.image!.isNotEmpty)
            ? data.image!
            : (profile.image != null && profile.image!.isNotEmpty)
                ? profile.image!
                : null;

        final updatedProfile = GetProfileDataModel(
          name: data.name ?? profile.name,
          email: data.email ?? profile.email,
          address: data.address ?? profile.address,
          image: newImageUrl,
          visa: data.visa ?? profile.visa,
        );

        context
            .read<GetProfileDataCubit>()
            .updateProfileFromUpload(updatedProfile);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }

      if (uploadState is PostProfileDataFailure) {
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
          width: 120.w,
          height: 50.h,
          backGroundColor: AppColors.primary,
          foreGroundColor: AppColors.white,
          onpressed: isLoading ? null : () => pickAndUploadImage(context),
          child: isLoading
              ? SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      color: Colors.white,
                    ),
                  ),
                )
              : const Text("Update Image"),
        ),
      );
    },
  );
}
