import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/const/const.dart';

import '../../services/provider/dark_theme.dart';

// ignore: must_be_immutable
class SignUpTextFieldWidget extends StatelessWidget {
  String hintText;
  // IconData prefixIcon;
  IconButton? suffixIcon;
  num screenNum;
  VoidCallback? showPassword;
  bool obscureText;
  TextInputType textInputType;
  TextEditingController controller;

  SignUpTextFieldWidget(
      {super.key,
      required this.hintText,
      // required this.prefixIcon,
      required this.controller,
      required this.textInputType,
      this.showPassword,
      this.suffixIcon,
      this.obscureText = false,
      this.screenNum = 0.92});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 48,
      width: screenSize.width * screenNum,
      decoration: BoxDecoration(
        color: Provider.of<DarkThemeProvider>(context).isDarkMode
            ? AppColor.darkBackground
            : AppColor.lightBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          hintText: hintText,
        ),
      ),
    );
  }
}
