import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OwnersShimmer extends StatelessWidget {
  const OwnersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 80,
        width: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
