import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/core/constants/app_colors.dart';
import 'package:foods_app/core/di/service_locator.dart';
import 'package:foods_app/core/helper/spacing.dart';
import 'package:foods_app/core/routes/bottom_navi_bar.dart';
import 'package:foods_app/core/shared/custom_bottom_sheet.dart';
import 'package:foods_app/features/cart/data/manager/getCartCubit/cart_cubit_cubit.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:foods_app/features/productDetalis/data/manager/cubit/order_request_cubit.dart';
import 'package:foods_app/features/productDetalis/data/model/oreder_request_model.dart';
import 'package:foods_app/features/productDetalis/widgets/item_count.dart';

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

        if (state is OrderRequestSuccess || state is OrderRequestFailure) {
          if (Navigator.canPop(context)) Navigator.pop(context);
        }

        if (state is OrderRequestSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.successMessage)));

          // 🔥 تحديث CartCubit بعد إضافة الطلب
          getIt<CartCubitCubit>().getCart(forceRefresh: true);

          // الانتقال للكارت مباشرة
          Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNaviBar(),
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
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        bottomSheet: BlocBuilder<OrderRequestCubit, OrderRequestState>(
          builder: (context, state) {
            return CustomBottomSheet(
              sheetText: 'Burger Price',
              bottomText: 'Add to Cart',
              price: _calculateTotalPrice().toStringAsFixed(2),
              isLoading: state is OrderRequestLoading,
              onpressed: () async {
                if (!mounted) return;

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
                      request: orderRequest,
                    );
              },
            );
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.08),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemDetaliedImage(product: widget.product),
                      SizedBox(
                        width: 170.w,
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
                ),
                verticalSpace(18.h),
                ItemCount(
                  onQuantityChanged: (val) {
                    setState(() {
                      quantity = val;
                    });
                  },
                ),
                verticalSpace(18.h),
                Text('Toppings', style: TextStyles.textStyle18),
                verticalSpace(18.h),
                ListviewToppingBuilder(
                  onSelectionChanged: (ids) {
                    setState(() {
                      selectedToppings = ids;
                    });
                  },
                ),
                verticalSpace(8.h),
                Text('Side Options', style: TextStyles.textStyle18),
                verticalSpace(8.h),
                ListviewSideOptionBuilder(
                  onSelectionChanged: (ids) {
                    setState(() {
                      selectedSideOptions = ids;
                    });
                  },
                ),
                verticalSpace(120.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
