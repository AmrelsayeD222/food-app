import 'package:flutter/material.dart';

class ItemDetaliedImage extends StatelessWidget {
  const ItemDetaliedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Image(
      height: 280,
      width: 150,
      image: AssetImage('assets/splash/burger_detalis.png'),
    );
  }
}
