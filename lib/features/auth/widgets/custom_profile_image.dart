import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  final String? imageUrl;

  const CustomProfileImage({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!)
              : const AssetImage('assets/detalis/sonic_profile.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
