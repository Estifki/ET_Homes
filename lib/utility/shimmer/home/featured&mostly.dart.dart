import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedAndMostlyShimmer extends StatelessWidget {
  const FeaturedAndMostlyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        margin: const EdgeInsets.all(12),
        height: screenSize.width > 370
            ? screenSize.height * 0.165
            : screenSize.height * 0.185,
        width: screenSize.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenSize.height * 0.14,
              width: screenSize.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Container(
                height: screenSize.height * 0.021,
                width: screenSize.width * 0.35,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Container(
                height: screenSize.height * 0.02,
                width: screenSize.width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
