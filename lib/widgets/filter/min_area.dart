import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

import '../../const/const.dart';

// ignore: must_be_immutable
class MinAreaWidget extends StatelessWidget {
  String value;
  VoidCallback onPressedplus;
  VoidCallback onPressedminus;

  MinAreaWidget(
      {super.key,
      required this.value,
      required this.onPressedplus,
      required this.onPressedminus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 36,
        width: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Provider.of<DarkThemeProvider>(context).isDarkMode
                ? AppColor.darkBackground
                : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onPressedminus,
              child: Container(
                height: 36,
                width: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColor.thirdColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.minus,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 18,
                    color: Provider.of<DarkThemeProvider>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                    fontFamily: AppFonts.medium),
                textAlign: TextAlign.start,
              ),
            ),
            GestureDetector(
              onTap: onPressedplus,
              child: Container(
                height: 36,
                width: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColor.thirdColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.plus,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
