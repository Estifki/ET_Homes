// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppColor {
  static const Color primaryColorCustom = Color(0xff216fed);
  static const Color secondayColorCustom = Color(0xff244d61);
  static const Color thirdColor = Color(0xff5a5a5a);
  static const Color lightBackground = Color(0xffedf2f6);
  static Color darkBackground = Colors.grey.withOpacity(0.15);
  static Color shadeGrey = Colors.grey.shade700;
}

class AppIcons {
  var bedIcon = SvgPicture.asset(
    AppAssets.bedIcon,
    height: 13.5,
    color: AppColor.primaryColorCustom,
  );
  var bathIcon = const Icon(
    FontAwesomeIcons.shower,
    size: 13.5,
    color: AppColor.primaryColorCustom,
  );

  Icon areaIcon = const Icon(
    Icons.aspect_ratio_outlined,
    size: 13.5,
    color: AppColor.primaryColorCustom,
  );
  var locationPin = SvgPicture.asset(
    AppAssets.locationIcon,
    height: 13.5,
    color: AppColor.primaryColorCustom,
  );
  // var bookmarkFilled = SvgPicture.asset(
  //   "assets/icons/bookmark_filled.svg",
  //   height: 22,
  //   color: Colors.red,
  // );
  // var bookmark = SvgPicture.asset(
  //   "assets/icons/bookmark.svg",
  //   height: 22,
  //   color: Provider.of<DarkThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
  // );
}

class AppAssets {
  static const String appLogo = "assets/icons/on1.svg";
  static const String bedIcon = "assets/icons/bed.svg";
  static const String locationIcon = "assets/icons/loc_pin.svg";
  static const String onBording01 = "assets/images/on1.svg";
  static const String onBording02 = "assets/images/on2.svg";
  static const String onBording03 = "assets/images/on3.svg";
  static const String noConnection = "assets/images/noconn.svg";
  static const String noPropertyFound = "assets/images/nofav.svg";
  static const String noFavourite = "assets/images/nofav.svg";
  static const String searching = "assets/searching.json";
  static const String circularLoading = "assets/circular_loading.json";
}

class AppRoutes {
  static const String bottomNavigationBar = "/bottom-NavBar";
  static const String companyDetails = "/company-Details";
  static const String propertyDetail = "/property-detail";
  static const String ownerProperties = "/owner-Properties";
  static const String bannerDetails = "/banner-data";
}

class AppConst {
  static String baseUrl =
      "https://zulu.up.railway.app/api"; // https://realethio-api.herokuapp.com/api
  static String oneSignalAppID = "7608d69f-6f09-4a5d-92be-2fae9fac8724";
}

class AppFonts {
  static const String title = "Fredoka-SemiBold";
  static const String black = "Montserrat-Black";
  static const String bold = "Montserrat-Bold";
  static const String extraLight = "Montserrat-ExtraLight";
  static const String light = "Montserrat-Light";
  static const String medium = "Montserrat-Medium";
  static const String regular = "Montserrat-Regular";
  static const String semiBold = "Montserrat-SemiBold";
  static const String thin = "Montserrat-Thin";
}

class AppTextSize {
  static double headerTitleSize = 20.5;
  static double propertyNameSize = 15.5;
  static double subTextSize = 12;
}

appBarStyle(Size screenSize) {
  return TextStyle(
    fontFamily: AppFonts.title,
    fontSize: AppTextSize.headerTitleSize,
  );
}
