import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../const/const.dart';

class NoPropertyFoundWidget extends StatelessWidget {
  final double fromTop;
  final String text;
  const NoPropertyFoundWidget(
      {super.key, this.text = "No Property Found", this.fromTop = 0.27});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenSize.height * fromTop),
          Center(
            child: SizedBox(
              height: screenSize.width * 0.35,
              child: SvgPicture.asset(AppAssets.noPropertyFound,
                  fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.1, right: screenSize.width * 0.1),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: AppFonts.medium,
                    fontSize: AppTextSize.propertyNameSize),
              ),
            ),
          )
        ]);
  }
}
