import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CompanyShimmer extends StatelessWidget {
  const CompanyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: screenSize.height * 0.12,
        width: screenSize.width,
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 30,
                  width: screenSize.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ]),
      ),
    );
  }
}
