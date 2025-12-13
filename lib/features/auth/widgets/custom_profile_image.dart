import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
        image: const DecorationImage(
          image: AssetImage(
            'assets/detalis/sonic_profile.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
