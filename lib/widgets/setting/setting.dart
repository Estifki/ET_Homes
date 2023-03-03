import 'package:flutter/material.dart';
import 'package:real_estate_project/const/const.dart';

// ignore: must_be_immutable
class CustomSettingListTilewidget extends StatelessWidget {
  String title;
  // IconData icon;

  CustomSettingListTilewidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: AppTextSize.propertyNameSize,
              fontFamily: AppFonts.medium,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_sharp,
              size: 15, color: AppColor.thirdColor),
        ],
      ),
    );
  }
}
