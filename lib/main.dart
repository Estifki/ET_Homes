import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_estate_project/screen/banner/banner_details.dart';
import 'package:real_estate_project/screen/company/company_details.dart';
import 'package:real_estate_project/services/provider/banner.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';
import 'package:real_estate_project/services/push_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
//

import 'services/auth/auth.dart';
import 'services/provider/save_for_later.dart';
import '/screen/owners/owner_properties.dart';
import 'services/provider/properties.dart';
import 'services/provider/location.dart';
import '/screen/property_details.dart';
import '/services/provider/agent.dart';

import '/utility/bottom_nav.dart';
import 'screen/splash.dart';
import '/const/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: AppColor.primaryColorCustom.withOpacity(0.5),
  // ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();
  Future getDarkThemeStatus() async {
    darkThemeProvider.setDarkTheme = await darkThemeProvider.getDarkTheme();
  }

  @override
  void initState() {
    super.initState();
    PushNotification.OneSignalPushNotification();
    getDarkThemeStatus();
  }

  @override
  Widget build(BuildContext context)  {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BannerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PropertiesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SaveForLaterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AgentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => darkThemeProvider,
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.myThemes(context, theme.isDarkMode),
          home: const SplashScreen(),
          routes: {
            AppRoutes.bottomNavigationBar: (ctx) => BottomNavagationScreen(),
            AppRoutes.propertyDetail: (ctx) => const PropertyDetailScreen(),
            AppRoutes.ownerProperties: (ctx) =>
                const SingleOwnerPropertiesScreen(),
            AppRoutes.companyDetails: (ctx) => const CompanyDetailsScreen(),
            AppRoutes.bannerDetails: (ctx) => const BannerDetailsScreen(),
          },
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
