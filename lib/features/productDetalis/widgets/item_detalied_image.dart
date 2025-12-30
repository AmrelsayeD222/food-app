import 'package:flutter/material.dart';
import 'package:foods_app/features/home/data/model/home_product_model.dart';

class ItemDetaliedImage extends StatelessWidget {
  const ItemDetaliedImage({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Image(
      height: 150,
      width: 150,
      fit: BoxFit.fill,
      image: NetworkImage(product.image),
    );
  }
}
