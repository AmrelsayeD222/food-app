import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/auth/data/model/get_profile_data_model.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper/text_style.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        final bool isSuccess = state is GetProfileDataSuccess;
        final bool isLoading =
            state is GetProfileDataLoading || state is LogoutLoading;

        // Create a dummy profile for skeleton loading
        final dummyProfile = GetProfileDataModel(
          name: 'John Doe',
          image: '',
        );

        final profile = isSuccess ? state.profileData : dummyProfile;

        // Use Skeletonizer if loading
        return Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/splash/splash_logo.svg',
                      width: 160.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Hello, Mr ${profile.name ?? '...'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textStyle16,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: profile.image ?? '',
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.person,
                        size: 40.sp,
                        color: Colors.grey,
                      );
                    },
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
