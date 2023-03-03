import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estate_project/const/const.dart';


class OnboardingWidget extends StatelessWidget {
 final String title;
 final String discription;
 final String imgUrl;
  OnboardingWidget(
      {required this.title, required this.discription, required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenSize.width * 0.6,
            child: SvgPicture.asset(
              imgUrl,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
                fontSize: AppTextSize.headerTitleSize,
                fontFamily: AppFonts.semiBold),
          ),
          const SizedBox(height: 8),
          Text(
            discription,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.thirdColor,
                fontSize: AppTextSize.subTextSize + 3,
                fontFamily: AppFonts.medium),
          ),
        ],
      ),
    );
  }
}
