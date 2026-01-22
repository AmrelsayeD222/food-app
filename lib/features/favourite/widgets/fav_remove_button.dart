import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';

class FavRemoveButton extends StatelessWidget {
  final int productId;

  const FavRemoveButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavCubit, ToggleFavState, bool>(
      selector: (state) => state.togglingProductIds.contains(productId),
      builder: (context, isToggling) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: isToggling
                ? null
                : () {
                    context.read<FavCubit>().toggleFavorite(
                          productId: productId,
                        );
                  },
            icon: isToggling
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.red,
                    ),
                  )
                : Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 22.sp,
                  ),
          ),
        );
      },
    );
  }
}
