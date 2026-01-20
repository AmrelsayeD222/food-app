import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_app/features/favourite/widgets/fav_item_card.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavLoading extends StatelessWidget {
  const FavLoading({super.key});

  List<Product> _getDummyProducts() {
    return List.generate(
      6,
      (index) => Product(
        id: index,
        name: 'Product Name',
        description: 'Product Description goes here in this field',
        image: '',
        rating: '4.5',
        price: '100.0',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: 6,
        itemBuilder: (_, index) {
          return FavItemCard(product: _getDummyProducts()[index]);
        },
      ),
    );
  }
}
