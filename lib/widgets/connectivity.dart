import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estate_project/const/const.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSize.width * 0.38,
              child:
                  SvgPicture.asset(AppAssets.noConnection, fit: BoxFit.contain),
            ),
            const SizedBox(height: 14),
            Text(
              "Ooops!",
              style: TextStyle(
                  fontSize: AppTextSize.headerTitleSize,
                  fontFamily: AppFonts.semiBold),
            ),
            const SizedBox(height: 6),
            Text(
              "No Internet Connection Found",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: AppTextSize.propertyNameSize,
                  color: AppColor.thirdColor,
                  fontFamily: AppFonts.medium),
            )
          ],
        ),
      ),
    );
  }
}
