import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/screen/profile/setting.dart';
import 'package:real_estate_project/utility/toast/show_message.dart';
import 'package:real_estate_project/widgets/auth/signup_textfield.dart';
import '../../const/const.dart';
import '../../services/auth/auth.dart';
import '../../services/profile.dart';
import '../../services/provider/dark_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _isloading = false;

  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = Provider.of<AuthProvider>(context, listen: false).userId!;
  }

  void showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Provider.of<DarkThemeProvider>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<DarkThemeProvider>(context).isDarkMode
            ? Colors.black
            : Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text("Change Password", style: appBarStyle(screenSize)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.width * 0.05),
              SignUpTextFieldWidget(
                hintText: "New password",
                textInputType: TextInputType.name,
                // prefixIcon: Icons.person,
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility, size: 0),
                ),
              ),
              const SizedBox(height: 15),
              SignUpTextFieldWidget(
                hintText: "Confirm new password",
                textInputType: TextInputType.name,
                // prefixIcon: Icons.person,
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () => showPassword(),
                  icon: _obscurePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 30),
              _isloading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () => validateUpdate(),
                      child: Container(
                        alignment: Alignment.center,
                        height: 42,
                        width: screenSize.width * 0.92,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColorCustom,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Update Password",
                          style: TextStyle(
                            fontSize: AppTextSize.propertyNameSize + 1,
                            color: Colors.white,
                            fontFamily: AppFonts.semiBold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  validateUpdate() async {
    if (_passwordController.text.length <= 5) {
      showErrorMessage(300, context, "Password must be at least 6 digit");
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showErrorMessage(240, context, "Password do not much");
    } else {
      try {
        setState(() {
          _isloading = true;
        });
        await ProfileApi.updatePassword(_userId, _passwordController.text)
            .then((_) {
          showSuccessMessage(240, context, "Password Changed");

          setState(() {
            _isloading = false;
            _passwordController.clear();
            _confirmPasswordController.clear();
          });
        });
      } catch (e) {
        // print(e.toString());
      } finally {
        Timer(
          const Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const SettingScreen(),
            ),
          ),
        );
      }
    }
  }
}
