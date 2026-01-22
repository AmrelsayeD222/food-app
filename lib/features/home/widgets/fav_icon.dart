import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/favourite/data/manager/toggle/fav_cubit.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

class FavIcon extends StatelessWidget {
  final int productId;
  final Product? product;

  const FavIcon({
    super.key,
    required this.productId,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavCubit, ToggleFavState,
        ({bool isFavorite, bool isToggling})>(
      selector: (state) => (
        isFavorite: state.favoriteIds.contains(productId),
        isToggling: state.togglingProductIds.contains(productId),
      ),
      builder: (context, data) {
        return GestureDetector(
          onTap: data.isToggling
              ? null
              : () {
                  context.read<FavCubit>().toggleFavorite(
                        productId: productId,
                        product: product,
                      );
                },
          child: Align(
            alignment: Alignment.topRight,
            child: data.isToggling
                ? SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.red,
                    ),
                  )
                : Icon(
                    data.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: data.isFavorite ? Colors.red : Colors.grey,
                    size: 22.sp,
                  ),
          ),
        );
      },
    );
  }
}
