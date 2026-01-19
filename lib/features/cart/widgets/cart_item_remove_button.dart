import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/cart/data/manager/getCartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/cart/data/manager/removeCart/remove_cubit.dart';

class CartItemRemoveButton extends StatelessWidget {
  final int itemId;

  const CartItemRemoveButton({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoveCubit, RemoveState>(
      listener: (context, state) {
        if (state is RemoveFailure && state.itemId == itemId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
        if (state is RemoveSuccess && state.itemId == itemId) {
          context.read<CartCubitCubit>().getCart(forceRefresh: true);
        }
      },
      builder: (context, state) {
        final loading = state is RemoveLoading && state.itemId == itemId;

        return IconButton(
          onPressed: loading
              ? null
              : () => context.read<RemoveCubit>().removeItem(itemId: itemId),
          icon: loading
              ? CircularProgressIndicator(strokeWidth: 2.w)
              : Icon(Icons.delete, color: Colors.red, size: 24.sp),
        );
      },
    );
  }
}
