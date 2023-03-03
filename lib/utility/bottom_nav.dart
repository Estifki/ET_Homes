import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/screen/company/company.dart';
import 'package:real_estate_project/screen/save_for_later.dart';
import 'package:real_estate_project/screen/home.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';
import 'package:real_estate_project/utility/user_auth_status.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

import '../widgets/connectivity.dart';

// ignore: must_be_immutable
class BottomNavagationScreen extends StatefulWidget {
  int selectedIndex;
  BottomNavagationScreen({super.key, this.selectedIndex = 0});
  @override
  State<BottomNavagationScreen> createState() => _BottomNavagationScreenState();
}

class _BottomNavagationScreenState extends State<BottomNavagationScreen> {
  final List<Widget> _allScreens = [
    const HomeScreen(),
    const CompaniesScreen(),
    const SaveForLaterScreen(),
    const UserAuthStatus()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
          connectivityBuilder: (context, connection, child) {
            bool isconnected = connection != ConnectivityResult.none;
            return isconnected
                ? _allScreens.elementAt(widget.selectedIndex)
                : const ConnectionError();
          },
          child: const SizedBox()),
      bottomNavigationBar: SizedBox(
        child: SalomonBottomBar(
          currentIndex: widget.selectedIndex,
          selectedItemColor: Provider.of<DarkThemeProvider>(context).isDarkMode
              ? Colors.grey.shade400
              : Colors.black,
          onTap: (i) => setState(() => widget.selectedIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                height: 18,
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.shade400
                    : Colors.black,
              ),
              title: const Text("Listing"),
            ),

            /// Explore
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/building.svg",
                height: 18,
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.shade400
                    : Colors.black,
              ),
              title: const Text("Agents"),
            ),

            /// bookmark
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/bookmark.svg",
                height: 18,
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.shade400
                    : Colors.black,
              ),
              title: const Text("Bookmark"),
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/user.svg",
                height: 18,
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? Colors.grey.shade400
                    : Colors.black,
              ),
              title: const Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
