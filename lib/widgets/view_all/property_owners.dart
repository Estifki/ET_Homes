import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

import '../../const/const.dart';

// ignore: must_be_immutable
class ViewAllPropertyOwnersWidget extends StatelessWidget {
  String id;
  String title;
  String imgUrl;

  ViewAllPropertyOwnersWidget(
      {super.key, required this.id, required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.ownerProperties,
          arguments: [id, title]),
      child: Container(
        
        decoration: BoxDecoration(
          color: Provider.of<DarkThemeProvider>(context).isDarkMode
              ? Colors.grey.withOpacity(0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenSize.width * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgUrl), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text(
                StringUtils.capitalize(title, allWords: true),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: AppTextSize.propertyNameSize,
                    fontFamily: AppFonts.medium,
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
