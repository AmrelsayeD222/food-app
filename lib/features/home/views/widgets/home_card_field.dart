import 'package:flutter/material.dart';
import 'package:foods_app/features/home/views/widgets/home_card.dart';

class HomeCardBuilder extends StatelessWidget {
  const HomeCardBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .75,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 50,
        (context, index) => const HomeCard(),
      ),
    );
  }
}
