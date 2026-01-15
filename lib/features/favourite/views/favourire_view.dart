import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/features/favourite/data/manager/fav/fav_cubit.dart';

class FavourireView extends StatefulWidget {
  const FavourireView({super.key});

  @override
  State<FavourireView> createState() => _FavourireViewState();
}

class _FavourireViewState extends State<FavourireView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = context.read<FavCubit>().state;
      if (currentState is GetFavInitial) {
        context.read<FavCubit>().getFavorites();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _FavAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FavCubit, FavState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                context.read<FavCubit>().getFavorites(isLoading: false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Item added to Favourites"),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state is AddFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          BlocListener<FavCubit, FavState>(
            listener: (context, state) {
              if (state is RemoveSuccess) {
                context.read<FavCubit>().getFavorites(isLoading: false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Item removed from Favourites"),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state is RemoveFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<FavCubit, FavState>(
          builder: (context, state) {
            if (state is GetFavLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state is GetFavFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.red.shade300,
                    ),
                    verticalSpace(20),
                    Text(
                      'Error loading favourites',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      state.error,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<FavCubit>().getFavorites();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is GetFavEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: Colors.grey.shade400,
                    ),
                    verticalSpace(20),
                    Text(
                      'No Favourites Yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      'Start adding items to your favourites!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is GetFavSuccess) {
              final favorites = state.response.data;

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FavCubit>().getFavorites();
                },
                color: AppColors.primary,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            horizontalSpace(12),

                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  verticalSpace(4),
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  verticalSpace(8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber.shade700,
                                      ),
                                      horizontalSpace(4),
                                      Text(
                                        product.rating,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '\$${product.price}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Remove Button
                            BlocBuilder<FavCubit, FavState>(
                              buildWhen: (previous, current) {
                                final prevIsRemoving =
                                    previous is RemoveLoading &&
                                        previous.productId == product.id;
                                final currIsRemoving =
                                    current is RemoveLoading &&
                                        current.productId == product.id;
                                return prevIsRemoving != currIsRemoving;
                              },
                              builder: (context, state) {
                                final isRemoving = state is RemoveLoading &&
                                    state.productId == product.id;

                                return IconButton(
                                  onPressed: isRemoving
                                      ? null
                                      : () {
                                          context.read<FavCubit>().toggleFav(
                                                productId: product.id,
                                                isAdding: false,
                                              );
                                        },
                                  icon: isRemoving
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.red,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 28,
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            // Default case
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ✅ AppBar منفصل عشان نعيد استخدامه
class _FavAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FavAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'My Favourites',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
