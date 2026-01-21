import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/home/data/manager/cubit/home_product_cubit.dart';

import '../../../../core/shared/custom_text_form_field.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(16.r)),
      child: CustomTextFormField(
        hintText: 'Search for food..',
        prefixIcon: const Icon(Icons.search),
        onChanged: (value) {
          context.read<HomeProductCubit>().searchProducts(value);
        },
      ),
    );
  }
}
