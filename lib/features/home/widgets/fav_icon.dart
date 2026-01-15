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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCubit, AddState>(
      listener: (context, addState) {
        if (addState is AddSuccess || addState is AddFailure) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
      child: BlocListener<RemoveCubit, RemoveState>(
        listener: (context, removeState) {
          if (removeState is RemoveSuccess || removeState is RemoveFailure) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          }
        },
        child: BlocBuilder<GetFavCubit, GetFavState>(
          builder: (context, getFavState) {
            final isFav = getFavState is GetFavSuccess &&
                getFavState.response.data.any((e) => e.id == widget.productId);

            return GestureDetector(
              onTap: _isLoading
                  ? null
                  : () {
                      setState(() {
                        _isLoading = true;
                      });

                      if (isFav) {
                        context.read<RemoveCubit>().removeFav(
                              token: widget.token,
                              productId: widget.productId,
                            );
                      } else {
                        context.read<AddCubit>().addFav(
                              token: widget.token,
                              productId: widget.productId,
                            );
                      }
                    },
              child: Align(
                alignment: Alignment.topRight,
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                    : Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                        size: 22,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
