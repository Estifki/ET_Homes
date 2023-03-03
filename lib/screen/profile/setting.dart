import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:real_estate_project/screen/profile/change_password.dart';
import 'package:real_estate_project/screen/profile/contact_us.dart';
import 'package:real_estate_project/screen/profile/update_profile.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

import '../../const/const.dart';
import '../../services/auth/auth.dart';
import '../../widgets/setting/setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text("Account Setting", style: appBarStyle(screenSize)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.width * 0.07),

            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen(),
                ),
              ),
              child: Container(
                height: 48,
                width: screenSize.width,
                decoration: BoxDecoration(
                    color: Provider.of<DarkThemeProvider>(context).isDarkMode
                        ? Colors.grey.withOpacity(0.15)
                        : Colors.white,
                    border: const Border(
                        top: BorderSide(width: 0.08, color: Colors.black54))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSettingListTilewidget(
                      title: "Update Profile",
                    ),
                  ],
                ),
              ),
            ),
            _blackLine(context),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              ),
              child: Container(
                height: 48,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Provider.of<DarkThemeProvider>(context).isDarkMode
                      ? Colors.grey.withOpacity(0.15)
                      : Colors.white,
                  border: const Border(
                      bottom: BorderSide(width: 0.08, color: Colors.black54)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSettingListTilewidget(
                      title: "Change Password",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.withOpacity(0.15)
                    : Colors.white,
                border: Border.all(width: 0.08, color: Colors.black54),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: ListTileSwitch(
                  value: Provider.of<DarkThemeProvider>(context, listen: false)
                      .isDarkMode,
                  // leading: Icon(Icons.mode_night_outlined),
                  visualDensity: VisualDensity.comfortable,
                  switchType: SwitchType.custom,
                  switchActiveColor: AppColor.primaryColorCustom,
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                        fontSize: AppTextSize.propertyNameSize,
                        fontFamily: AppFonts.medium),
                  ),
                  onChanged: (value) {
                    setState(() {
                      Provider.of<DarkThemeProvider>(context, listen: false)
                          .setDarkTheme = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContactUsScreen(),
                ),
              ),
              child: Container(
                height: 48,
                width: screenSize.width,
                decoration: BoxDecoration(
                    color: Provider.of<DarkThemeProvider>(context).isDarkMode
                        ? Colors.grey.withOpacity(0.15)
                        : Colors.white,
                    border: const Border(
                        top: BorderSide(width: 0.08, color: Colors.black54))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSettingListTilewidget(
                      title: "Contact Us",
                    ),
                  ],
                ),
              ),
            ),
            _blackLine(context),
            Container(
              height: 48,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.withOpacity(0.15)
                    : Colors.white,
                border: const Border(
                    bottom: BorderSide(width: 0.08, color: Colors.black54)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ),
                    ),
                    child: CustomSettingListTilewidget(
                      title: "Frequently Asked Questions",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Container(
              height: 48,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.withOpacity(0.15)
                    : Colors.white,
                border: Border.all(width: 0.08, color: Colors.black54),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSettingListTilewidget(
                    title: "About Us",
                  ),
                ],
              ),
            ),

            //
            //Log Out
            //
            SizedBox(height: screenSize.width * 0.12),
            GestureDetector(
              onTap: () => Provider.of<AuthProvider>(context, listen: false)
                  .signOut()
                  .then(
                    (value) => Navigator.pop(
                      context,
                    ),
                  ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.shadeGrey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.power_settings_new_sharp,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                              fontFamily: AppFonts.semiBold,
                              fontSize: AppTextSize.propertyNameSize + 1.5),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _blackLine(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width,
        color: Provider.of<DarkThemeProvider>(context).isDarkMode
            ? AppColor.thirdColor
            : Colors.black87,
        height: 0.1);
  }
}
