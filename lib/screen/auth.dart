import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';

//
import '../services/auth/auth.dart';
import '../widgets/auth/signup_textfield.dart';
import '/utility/http_exception.dart';
import '/const/const.dart';
import '/utility/toast/show_message.dart';
import '/widgets/auth/login_with.dart';
import '../widgets/auth/signin_textfield.dart';

enum AuthMode { login, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _loginPhoneController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  AuthMode _authMode = AuthMode.login;
  bool _obscurePassword = true;
  bool _loginLoading = false;
  bool _registerLoading = false;
  void showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void setAuthMode(bool isLogin) {
    if (isLogin) {
      setState(() {
        _authMode = AuthMode.login;
      });
    } else {
      setState(() {
        _authMode = AuthMode.register;
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Provider.of<DarkThemeProvider>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      body: ListView(physics: const BouncingScrollPhysics(), children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.fastLinearToSlowEaseIn,
            height: _authMode == AuthMode.login
                ? screenSize.height * 0.3
                : screenSize.height * 0.25,
            width: screenSize.width,
            child: Transform.scale(
              scale: screenSize.width > 370
                  ? screenSize.width * 0.002
                  : screenSize.width * 0.0028,
              child: _authMode == AuthMode.login
                  ? SvgPicture.asset(
                      "assets/images/register.svg",
                      fit: BoxFit.contain,
                    )
                  : SvgPicture.asset(
                      "assets/images/login.svg",
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
        SizedBox(
            width: screenSize.width,
            child: _authMode == AuthMode.login
                ? _signIn(screenSize)
                : _signUp(screenSize)),
      ]),
    );
  }

  Widget _signIn(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.04),
              child: Text(
                "Sign in to Your Account",
                style: TextStyle(
                    fontSize: AppTextSize.headerTitleSize,
                    fontFamily: AppFonts.title),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Center(
              child: Container(
                height: 48,
                width: screenSize.width * 0.92,
                decoration: BoxDecoration(
                  color: Provider.of<DarkThemeProvider>(context).isDarkMode
                      ? AppColor.darkBackground
                      : AppColor.lightBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 8),
                      child: Text("251",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "",
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColorCustom)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _loginPhoneController,
                        maxLength: 9,
                        onChanged: (val) {
                          if (!val.startsWith("9")) {
                            _loginPhoneController.clear();
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            hintText: "Phone"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Center(
              child: SignInTextFieldWidget(
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                // prefixIcon: Icons.lock,
                controller: _loginPasswordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () => showPassword(),
                  icon: _obscurePassword
                      ? const Icon(Icons.visibility_off, size: 22)
                      : const Icon(Icons.visibility, size: 22),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Center(
              child: _loginLoading
                  ? Transform.scale(
                      scale: 0.7,
                      child: const CircularProgressIndicator(
                        color: AppColor.primaryColorCustom,
                      ),
                    )
                  : InkWell(
                      onTap: () => validateLogin(),
                      child: Container(
                        alignment: Alignment.center,
                        height: 42,
                        width: screenSize.width * 0.92,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColorCustom,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: AppTextSize.propertyNameSize + 1,
                              color: Colors.white,
                              fontFamily: AppFonts.semiBold),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: screenSize.height * 0.035,
            ),
            Center(
              child: Center(
                child: Text(
                  "Login with",
                  style: TextStyle(
                      fontFamily: AppFonts.medium,
                      fontSize: AppTextSize.subTextSize),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.035,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  right: screenSize.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginWithWidget(
                      loginWithText: "Google",
                      imgUrl: "assets/images/gmail.png",
                      onpressed: () async {
                        try {
                          await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .signInWithGoogle();
                        } on HttpException catch (error) {
                          showErrorMessage(screenSize.width * 0.6, context,
                              error.toString());
                        }
                      }),
                  SizedBox(width: screenSize.width * 0.1),
                  LoginWithWidget(
                    loginWithText: "Facebook",
                    imgUrl: "assets/images/facebook.png",
                    onpressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            GestureDetector(
              onTap: () => setAuthMode(false),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont't have an account? ",
                    style: TextStyle(
                        fontSize: AppTextSize.propertyNameSize,
                        fontFamily: AppFonts.medium),
                  ),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: AppTextSize.propertyNameSize + 1,
                        color: AppColor.primaryColorCustom,
                        fontFamily: AppFonts.semiBold),
                  )
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
          ],
        ),
      ),
    );
  }

  Widget _signUp(Size screenSize) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.04),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: AppTextSize.headerTitleSize,
                  fontFamily: AppFonts.title),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignUpTextFieldWidget(
                screenNum: 0.45,
                hintText: "First name",
                textInputType: TextInputType.name,
                controller: _firstNameController,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility, size: 0),
                ),
              ),
              SizedBox(width: screenSize.width * 0.02),
              SignUpTextFieldWidget(
                screenNum: 0.45,
                hintText: "Last name",
                textInputType: TextInputType.name,
                controller: _lastNameController,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility, size: 0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Center(
            child: SignUpTextFieldWidget(
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              // prefixIcon: Icons.email,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility, size: 0),
              ),
              controller: _emailController,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Center(
            child: Container(
              height: 48,
              width: screenSize.width * 0.92,
              decoration: BoxDecoration(
                color: Provider.of<DarkThemeProvider>(context).isDarkMode
                    ? AppColor.darkBackground
                    : AppColor.lightBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Text("251",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "",
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColorCustom)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      maxLength: 9,
                      onChanged: (val) {
                        if (!val.startsWith("9")) {
                          _phoneController.clear();
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                        hintText: "Phone",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Center(
            child: SignUpTextFieldWidget(
              hintText: "Password",
              textInputType: TextInputType.visiblePassword,
              // prefixIcon: Icons.lock,
              controller: _passwordController,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility, size: 0),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Center(
            child: SignUpTextFieldWidget(
              hintText: "Confirm Password",
              textInputType: TextInputType.visiblePassword,
              // prefixIcon: Icons.lock,
              controller: _confirmPasswordController,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () => showPassword(),
                icon: _obscurePassword
                    ? const Icon(Icons.visibility_off, size: 20)
                    : const Icon(Icons.visibility, size: 20),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          Center(
            child: _registerLoading
                ? Transform.scale(
                    scale: 0.7,
                    child: const CircularProgressIndicator(
                      color: AppColor.primaryColorCustom,
                    ),
                  )
                : InkWell(
                    onTap: () => validateRegister(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 42,
                      width: screenSize.width * 0.92,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColorCustom,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                            fontSize: AppTextSize.propertyNameSize + 1,
                            color: Colors.white,
                            fontFamily: AppFonts.semiBold),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          GestureDetector(
            onTap: () => setAuthMode(true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member? ",
                  style: TextStyle(
                      fontSize: AppTextSize.propertyNameSize,
                      fontFamily: AppFonts.medium),
                ),
                Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: AppTextSize.propertyNameSize + 1,
                      color: AppColor.primaryColorCustom,
                      fontFamily: AppFonts.semiBold),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
        ],
      ),
    );
  }

  Future<void> validateLogin() async {
    if (_loginPhoneController.text.isEmpty) {
      showErrorMessage(220, context, "Phone is Empty");
      return;
    }
    if (_loginPhoneController.text.length != 9) {
      showErrorMessage(220, context, "Invalid Phone number");

      return;
    }
    if (_loginPasswordController.text.isEmpty) {
      showErrorMessage(220, context, "Password Field is Empty");
    } else if (_loginPasswordController.text.length <= 5) {
      showErrorMessage(220, context, "Password must be at least 6 digit");
    } else {
      try {
        setState(() {
          _loginLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .signIn(
                phone: int.parse(_loginPhoneController.text),
                password: _loginPasswordController.text)
            .then((_) {
          setState(() {
            _loginLoading = false;
          });
          Navigator.pushReplacementNamed(
              context, AppRoutes.bottomNavigationBar);
        });
      } on HttpException catch (error) {
        var errorMessage = 'Authentication failed';
        if (error.toString().contains('Invalid password')) {
          errorMessage = 'Invalid password';
        } else if (error.toString().contains("User doesn't exist")) {
          errorMessage = "User doesn't exist";
        }
        showErrorMessage(220, context, errorMessage);
      } catch (error) {
        showErrorMessage(220, context, error.toString());
      }
      setState(() {
        _loginLoading = false;
      });
    }
  }

  Future<void> validateRegister() async {
    if (_firstNameController.text.isEmpty ||
        _firstNameController.text.length < 2) {
      showErrorMessage(260, context, "Please provide correct First name");
    } else if (_lastNameController.text.isEmpty ||
        _lastNameController.text.length < 2) {
      showErrorMessage(260, context, "Please provide correct Last name");
    } else if (_emailController.text.isEmpty) {
      showErrorMessage(260, context, "Can not leave Email Empty");
    } else if (!_emailController.text.contains("@")) {
      showErrorMessage(260, context, "Please provide correct Email");
    } else if (!_emailController.text.endsWith(".com")) {
      showErrorMessage(260, context, "Please provide correct Email");
    } else if (_phoneController.text.isEmpty) {
      showErrorMessage(220, context, "Can not leave Phone Empty");
    } else if (_phoneController.text.length != 9) {
      showErrorMessage(220, context, "Please provide correct Phone num");
    } else if (_passwordController.text.length < 5) {
      showErrorMessage(220, context, "Password must be at least 6 digit");
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showErrorMessage(220, context, "Password do not much");
    } else {
      try {
        setState(() {
          _registerLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                password: _passwordController.text)
            .then(
              (_) => showSuccessMessage(
                220,
                context,
                "User Registered Sucessfully",
              ),
            )
            .then((_) {
          setState(() {
            _registerLoading = false;
            _authMode = AuthMode.login;
          });
        });
      } on HttpException catch (error) {
        var errorMessage = 'Authentication failed';
        if (error.toString().contains('phone already in use')) {
          errorMessage = 'Phone already in use';
        }
        if (error.toString().contains('email already in use')) {
          errorMessage = 'Email already in use';
        }
        showErrorMessage(220, context, errorMessage);
      } catch (error) {
        showErrorMessage(220, context, error.toString());
      }
      setState(() {
        _registerLoading = false;
      });
    }
  }
}
