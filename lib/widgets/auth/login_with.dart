import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

import '../../const/const.dart';

// ignore: must_be_immutable
class LoginWithWidget extends StatelessWidget {
  String loginWithText;
  Color? primaryColorCustom;
  String imgUrl;
  VoidCallback onpressed;
  LoginWithWidget(
      {super.key,
      required this.loginWithText,
      this.primaryColorCustom,
      required this.imgUrl,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 40,
        width: screenSize.width * 0.41,
        decoration: BoxDecoration(
          color: Provider.of<DarkThemeProvider>(context).isDarkMode
              ? AppColor.darkBackground
              : AppColor.lightBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black54, width: 0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgUrl), fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Center(
              child: Text(
                loginWithText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: AppTextSize.propertyNameSize - 1,
                    fontFamily: AppFonts.semiBold),
              ),
            ),
            const Text("    ")
          ],
        ),
      ),
    );
  }
}
