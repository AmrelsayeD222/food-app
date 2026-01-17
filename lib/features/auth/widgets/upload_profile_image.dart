import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/features/auth/manager/Post_profile_data_cubit.dart/post_profile_data_cubit.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickAndUploadImage(BuildContext context) async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);

  if (picked == null) return;

  if (!context.mounted) return;

  context.read<PostProfileDataCubit>().postProfileData(
        imagePath: picked.path,
      );
}
