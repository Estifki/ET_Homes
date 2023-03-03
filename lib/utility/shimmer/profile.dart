import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColor.darkBackground,
          child: Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.05),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // //
                  // //Setting
                  // //
                  // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  //   Padding(
                  //     padding: const EdgeInsets.only(right: 8.0),
                  //     child: Container(
                  //       height: 26,
                  //       width: 26,
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey,
                  //         shape: BoxShape.circle,
                  //       ),
                  //     ),
                  //   )
                  // ]),
                  //
                  //User Photo
                  //

                  Container(
                    height: screenSize.width * 0.25,
                    width: screenSize.width * 0.25,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                  //
                  //UserName
                  //
                  SizedBox(height: screenSize.height * 0.02),
                  Container(
                    height: 19,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 5),
                  //
                  //User Phone Num
                  //
                  const SizedBox(
                    height: 17.5,
                    width: 120,
                  ),
                  SizedBox(height: screenSize.height * 0.07),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      //
                      //Profile Email
                      //
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          height: 19,
                          width: 120,
                        ),
                      ),
                      //
                      //Profile Joined Date
                      //
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          height: 19,
                          width: 90,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 24,
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
      ],
    );
  }
}
