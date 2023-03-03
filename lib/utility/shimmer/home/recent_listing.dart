import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecentListingShimmer extends StatelessWidget {
  const RecentListingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        margin: const EdgeInsets.all(12),
        height: screenSize.height * 0.2,
        width: screenSize.width,
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenSize.height * 0.18,
                width: screenSize.width * 0.5,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(width: 10),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      height: 18,
                      width: screenSize.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 18,
                      width: screenSize.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ])
            ],
          ),
          Positioned(
              right: screenSize.width * 0.015,
              bottom: screenSize.height * 0.025,
              child: Container(
                height: 18,
                width: screenSize.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ))
        ]),
      ),
    );
  }
}
