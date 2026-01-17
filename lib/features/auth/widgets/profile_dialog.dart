import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/routes/app_routes.dart';
import 'package:foods_app/features/auth/manager/get_profile_data_cubit/get_profile_data_cubit.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.black,
              backgroundColor: AppColors.white,
            ),
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.red,
              backgroundColor: AppColors.white,
            ),
            child: const Text("Logout"),
            onPressed: () async {
              // Close dialog first
              Navigator.of(dialogContext).pop();

              // Get the outer context before async operation
              if (!context.mounted) return;
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                AppRoutes.signUp,
                (route) => false,
              );
              // Perform logout
              await context.read<GetProfileDataCubit>().logout();
            },
          ),
        ],
      );
    },
  );
}
