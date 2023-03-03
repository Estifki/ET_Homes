import 'package:flutter/material.dart';

import '../../const/const.dart';

// ignore: must_be_immutable
class HomeAmentiesWidget extends StatelessWidget {
  String bedRoom;
  String bathRoom;
  String propertyArea;

  HomeAmentiesWidget(
      {super.key,
      required this.bathRoom,
      required this.bedRoom,
      required this.propertyArea});

  var textsize = const TextStyle(fontSize: 12, fontFamily: AppFonts.medium);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Row(
              children: [
                AppIcons().bedIcon,
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.008),
                  child: Text(
                    bedRoom,
                    style: textsize,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: screenSize.width * 0.014,
            //       right: screenSize.width * 0.014),
            //   child: Container(
            //     height: screenSize.height * 0.015,
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 0.5, color: Colors.black54)),
            //   ),
            // ),
            Row(
              children: [
                AppIcons().bathIcon,
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.008),
                  child: Text(
                    bathRoom,
                    style: textsize,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: screenSize.width * 0.014,
            //       right: screenSize.width * 0.014),
            //   child: Container(
            //     height: screenSize.height * 0.015,
            //     decoration: BoxDecoration(
            //       border: Border.all(width: 0.5, color: Colors.black54),
            //     ),
            //   ),
            // ),
            Row(
              children: [
                AppIcons().areaIcon,
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.008),
                  child: Text(
                    "$propertyArea Sq.M",
                    style: textsize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
