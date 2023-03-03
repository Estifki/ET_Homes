import 'package:flutter/material.dart';

import '../../const/const.dart';

// ignore: must_be_immutable
class Amenties1Widget extends StatelessWidget {
  int quantity;
  String quantityName;

  Amenties1Widget({super.key, required this.quantity, required this.quantityName});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.07,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "$quantity",
          style: TextStyle(
              fontSize: AppTextSize.headerTitleSize - 2,
              fontFamily: AppFonts.medium,
              color: AppColor.thirdColor),
        ),
        Text(
          quantityName,
          style: TextStyle(
              fontSize: AppTextSize.propertyNameSize - 2,
              fontFamily: AppFonts.semiBold,
              color: AppColor.thirdColor),
        ),
      ]),
    );
  }
}

// ignore: must_be_immutable
class Amenties2Widget extends StatelessWidget {
  String amenties;

  Amenties2Widget({super.key, 
    required this.amenties,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.5,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            amenties,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppTextSize.subTextSize + 2,
                fontFamily: AppFonts.medium),
          ),
        ),
      ),
    );
  }
}
