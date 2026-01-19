import 'package:flutter/material.dart';

class CartItemImage extends StatelessWidget {
  final String image;

  const CartItemImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        image,
        width: 100,
        height: 100,
        fit: BoxFit.fill,
        errorBuilder: (_, __, ___) => _placeholder(),
        loadingBuilder: (_, child, progress) =>
            progress == null ? child : _placeholder(isLoading: true),
      ),
    );
  }

  Widget _placeholder({bool isLoading = false}) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[200],
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(strokeWidth: 2)
            : const Icon(Icons.image_not_supported),
      ),
    );
  }
}
