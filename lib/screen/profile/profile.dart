// ignore_for_file: deprecated_member_use

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:real_estate_project/const/const.dart';
import 'package:real_estate_project/model/user_profile.dart';
import 'package:real_estate_project/screen/auth.dart';
import 'package:real_estate_project/screen/profile/setting.dart';

import 'package:real_estate_project/services/profile.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';
import 'package:real_estate_project/utility/shimmer/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/auth/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreentState();
}

class _ProfileScreentState extends State<ProfileScreen> {
  late Future<UserProfileModel> _profileData;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _profileData = ProfileApi.getUserProfile(
          Provider.of<AuthProvider>(context, listen: false).userId);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<UserProfileModel>(
          future: _profileData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Provider.of<AuthProvider>(context, listen: false).signOut();
              return const AuthScreen();
            } else if (snapshot.hasData) {
              UserProfileModel? data = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Provider.of<DarkThemeProvider>(context).isDarkMode
                          ? AppColor.darkBackground
                          : const Color(0xff2273b4),
                      child: Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //
                            //Setting
                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) =>
                                                const SettingScreen(),
                                          ),
                                        ),
                                    icon: SvgPicture.asset(
                                      "assets/icons/settings.svg",
                                      height: 21,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            //
                            //User Photo
                            //

                            Container(
                              height: screenSize.width * 0.25,
                              width: screenSize.width * 0.25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(data!.profile.profile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            //
                            //UserName
                            //
                            SizedBox(height: screenSize.height * 0.015),
                            SelectableText(
                              StringUtils.capitalize(
                                  data.profile.firstName +
                                      " " +
                                      data.profile.lastName,
                                  allWords: true),
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: AppFonts.semiBold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 3),
                            //
                            //User Phone Num
                            //
                            SelectableText(
                              data.profile.phone
                                  .toString()
                                  .replaceAll("251", "+251 "),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: AppFonts.medium,
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.07),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //
                                //Profile Email
                                //
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data.profile.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: AppFonts.medium,
                                    ),
                                  ),
                                ),
                                //
                                //Profile Joined Date
                                //
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Since ${data.profile.createdAt.year}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: AppFonts.medium,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    //
                    //Request of Listing
                    //

                    Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.camera_outdoor_sharp,
                            color: Provider.of<DarkThemeProvider>(context)
                                    .isDarkMode
                                ? Colors.grey.shade300
                                : AppColor.thirdColor,
                            size: 23,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              try {
                                await launchUrl(
                                  Uri(
                                      scheme: "https",
                                      path: "realesatate-landing.vercel.app/"),
                                );
                              } catch (e) {}
                            },
                            child: Text(
                              "Request for Property Listing",
                              style: TextStyle(
                                  fontSize: AppTextSize.propertyNameSize,
                                  fontFamily: AppFonts.medium,
                                  color: Provider.of<DarkThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.grey.shade300
                                      : AppColor.thirdColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const ProfileShimmer();
            }
          }),
    );
  }
}
