import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/features/favourite/data/manager/AddAndRemove/add_and_remove_cubit.dart';
import 'package:foods_app/features/favourite/data/manager/Get/get_cubit.dart';

class FavIcon extends StatefulWidget {
  final int productId;
  final String token;

  const FavIcon({
    super.key,
    required this.productId,
    required this.token,
  });

  @override
  State<FavIcon> createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavCubit, GetFavState>(builder: (context, state) {
      final isFav = state is GetFavSuccess &&
          state.response.data.any((e) => e.id == widget.productId);

      return GestureDetector(
        onTap: () async {
          if (isFav) {
            print(
                '🔴 LOG: Tapped Remove Fav for Product ID: ${widget.productId}');
            context.read<RemoveCubit>().removeFav(
                  token: widget.token,
                  productId: widget.productId,
                );
          } else {
            print('🟢 LOG: Tapped Add Fav for Product ID: ${widget.productId}');
            context.read<AddCubit>().addFav(
                  token: widget.token,
                  productId: widget.productId,
                );
          }
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
            size: 22,
          ),
        ),
      );
    });
  }
}
