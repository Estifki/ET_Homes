import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

// ignore: must_be_immutable
class CompaniesWidget extends StatelessWidget {
  String id, name, logo;

  CompaniesWidget(
      {super.key, required this.id, required this.name, required this.logo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.companyDetails,
          arguments: [id, name]),
      child: Container(
        color: Provider.of<DarkThemeProvider>(context).isDarkMode
            ? AppColor.darkBackground
            : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: logo,

                    // placeholder: (context, url) => Container(
                    //   height: screenSize.width > 370
                    //       ? screenSize.height * 0.22
                    //       : screenSize.height * 0.26,
                    //   width: screenSize.width * 0.5,
                    //   color: Colors.grey.shade200,
                    // ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              StringUtils.capitalize(name, allWords: true),
              style: TextStyle(
                  fontFamily: AppFonts.semiBold,
                  fontSize: AppTextSize.propertyNameSize),
            ),
          ],
        ),
      ),
    );
  }
}
