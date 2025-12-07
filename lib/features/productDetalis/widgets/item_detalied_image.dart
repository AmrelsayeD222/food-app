import 'package:flutter/material.dart';

class ItemDetaliedImage extends StatelessWidget {
  const ItemDetaliedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width * 0.35,
      image: const AssetImage('assets/splash/burger_detalis.png'),
    );
  }
}
