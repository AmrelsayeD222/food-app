import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/bottom_navi_bar.dart';
import 'package:foods_app/core/shared/custom_bottom_sheet.dart';
import 'package:foods_app/features/cart/data/manager/cartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/productDetalis/data/manager/cubit/order_request_cubit.dart';
import 'package:foods_app/features/productDetalis/data/model/oreder_request_model.dart';
import 'package:foods_app/features/productDetalis/widgets/item_count.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/text_style.dart';
import '../widgets/custom_slider.dart';
import '../widgets/explain_text.dart';
import '../widgets/item_detalied_image.dart';
import '../widgets/listview_side_option_builder.dart';
import '../widgets/listview_topping_builder.dart';

class ProductDetalisView extends StatefulWidget {
  final Product product;

  const ProductDetalisView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetalisView> createState() => _ProductDetalisViewState();
}

class _ProductDetalisViewState extends State<ProductDetalisView> {
  int quantity = 1;
  double spicyLevel = 0.5;
  List<int> selectedToppings = [];
  List<int> selectedSideOptions = [];

  double _calculateTotalPrice() {
    return (double.tryParse(widget.product.price.toString()) ?? 0.0) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderRequestCubit, OrderRequestState>(
      listener: (context, state) async {
        if (!mounted) return;

        if (state is OrderRequestLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is OrderRequestSuccess || state is OrderRequestFailure) {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }

        if (state is OrderRequestSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.successMessage)));

          // 🔥 تحديث CartCubit بعد إضافة الطلب
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null && token.isNotEmpty) {
            getIt<CartCubitCubit>().getCart(token: token, forceRefresh: true);
          }

          // الانتقال للكارت مباشرة
          Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNaviBar(initialIndex: 1),
            ),
            (route) => false,
          );
        }

        if (state is OrderRequestFailure) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        bottomSheet: CustomBottomSheet(
          sheetText: 'Burger Price',
          bottomText: 'Add to Cart',
          price: _calculateTotalPrice().toStringAsFixed(2),
          onpressed: () async {
            if (!mounted) return;

            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('token');

            if (token == null || token.isEmpty) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please login first')),
              );
              return;
            }

            final orderItem = OrderItem(
              productId: widget.product.id,
              quantity: quantity,
              spicy: spicyLevel,
              toppings: selectedToppings,
              sideOptions: selectedSideOptions,
            );

            final orderRequest = OrderRequest(items: [orderItem]);

            // ignore: use_build_context_synchronously
            context.read<OrderRequestCubit>().createOrder(
                  token: token,
                  request: orderRequest,
                );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemDetaliedImage(product: widget.product),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ExplainText(),
                          CustomSlider(
                            initialValue: spicyLevel,
                            onChanged: (value) {
                              setState(() {
                                spicyLevel = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                ItemCount(
                  onQuantityChanged: (val) {
                    setState(() {
                      quantity = val;
                    });
                  },
                ),
                verticalSpace(20),
                const Text('Toppings', style: TextStyles.textStyle18),
                verticalSpace(20),
                ListviewToppingBuilder(
                  onSelectionChanged: (ids) {
                    setState(() {
                      selectedToppings = ids;
                    });
                  },
                ),
                verticalSpace(20),
                const Text('Side Options', style: TextStyles.textStyle18),
                verticalSpace(20),
                ListviewSideOptionBuilder(
                  onSelectionChanged: (ids) {
                    setState(() {
                      selectedSideOptions = ids;
                    });
                  },
                ),
                verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
