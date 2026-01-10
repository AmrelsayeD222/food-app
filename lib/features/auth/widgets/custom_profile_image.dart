import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  final String? imageUrl;

  const CustomProfileImage({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Image.network(
              imageUrl!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _placeholder();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 150,
      height: 150,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        size: 40,
        color: Colors.grey,
      ),
    );
  }
}
