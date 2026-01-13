import 'package:flutter/material.dart';
import 'package:foods_app/core/constants/app_colors.dart';

class FavIcon extends StatefulWidget {
  const FavIcon({
    super.key,
  });

  @override
  State<FavIcon> createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? AppColors.red : AppColors.grey,
          size: 22,
        ),
      ),
    );
  }
}
