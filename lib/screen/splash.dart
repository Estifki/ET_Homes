import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
import '../services/auth/auth.dart';

import '../utility/bottom_nav.dart';
import '../services/provider/location.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).getUserAndToken();
      Provider.of<LocationProvider>(context, listen: false)
          .GetUserCurrentPosition();
    });
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                  builder: (context) => BottomNavagationScreen()),
            ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/app_logo.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
