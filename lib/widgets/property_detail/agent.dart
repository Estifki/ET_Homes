import 'package:flutter/material.dart';
import 'package:real_estate_project/const/const.dart';

// ignore: must_be_immutable
class AgentWidget extends StatelessWidget {
  String firstName, lastName;
  String imgUrl;

  AgentWidget({
    required this.firstName,
    required this.lastName,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.05, right: screenSize.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(imgUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstName + " " + lastName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: AppFonts.semiBold,
                      fontSize: screenSize.width * 0.042),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                //   child: Text(
                //     'Agent',
                //     overflow: TextOverflow.ellipsis,
                //     textAlign: TextAlign.center,
                //     maxLines: 1,
                //     style: TextStyle(
                //       color: AppColor.shadeGrey,
                //       fontFamily: AppFonts.regular,
                //       fontSize: screenSize.width * 0.035,
                //     ),
                //   ),
                // )
              ]),
          const Spacer(),
          const Center(
              child: Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.wifi_calling_3_rounded,
              color: AppColor.primaryColorCustom,
              size: 26,
            ),
          ))
        ],
      ),
    );
  }
}
