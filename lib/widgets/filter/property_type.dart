import 'package:flutter/material.dart';
import 'package:real_estate_project/const/const.dart';

// ignore: must_be_immutable
class SelectableFilterWidget extends StatelessWidget {
  String name;
  Color activeColor;
  SelectableFilterWidget(
      {super.key, required this.name, required this.activeColor});
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Container(
      height: screensize.height * 0.04,
      width: screensize.width * 0.145,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: activeColor, width: 1.5),
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13.5, color: activeColor, fontFamily: AppFonts.semiBold),
      ),
    );
  }
}
