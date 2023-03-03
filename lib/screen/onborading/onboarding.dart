import 'package:flutter/material.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/onboarding/onboarding.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool _lastPage = false;

  final TextStyle _textStyle = TextStyle(
      fontSize: AppTextSize.propertyNameSize + 1,
      color: AppColor.primaryColorCustom,
      fontFamily: AppFonts.semiBold);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 2) {
                _lastPage = true;
              } else {
                _lastPage = false;
              }
            });
          },
          children: [
            OnboardingWidget(
                title: "Welcome to ET_Homes",
                discription:
                    "Find the ideal place according to your\nneeds and expectation.",
                imgUrl: AppAssets.onBording01),
            OnboardingWidget(
                title: "Real Estate Agent",
                discription:
                    "Your guarantee will be Your official\nidentifaction,no more problem.",
                imgUrl: AppAssets.onBording02),
            OnboardingWidget(
                title: "Buy & Sell Houses",
                discription:
                    "Buy & sell your expected house\nfrom phone with Et homes.",
                imgUrl: AppAssets.onBording03),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: screenSize.height * 0.05),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.jumpToPage(2);
                      });
                    },
                    child: _lastPage
                        ? const SizedBox()
                        : Text(
                            "Skip",
                            style: _textStyle,
                          )),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(dotHeight: 3.5),
                ),
                _lastPage
                    ? GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, AppRoutes.bottomNavigationBar),
                        child: Text(
                          "Done",
                          style: _textStyle,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeIn);
                          });
                        },
                        child: Text(
                          "Next",
                          style: _textStyle,
                        ),
                      ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
