import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: const CustomTextFormField(
        hintText: 'Search..',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
