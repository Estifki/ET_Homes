import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

// ignore: must_be_immutable
class OwnersWidget extends StatelessWidget {
  String id;
  String ownerName;
  String imgUrl;

  OwnersWidget(
      {super.key,
      required this.id,
      required this.ownerName,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.ownerProperties,
          arguments: [id, ownerName]),
      child: Container(
        margin: const EdgeInsets.only(top: 5, right: 8, left: 2),
        width: screenSize.width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.withOpacity(0.15)
                    : AppColor.shadeGrey.withOpacity(0.1),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              StringUtils.capitalize(ownerName, allWords: true),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: AppTextSize.subTextSize,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppFonts.medium),
            )
          ],
        ),
      ),
    );
  }
}
