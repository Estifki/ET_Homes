import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../services/provider/dark_theme.dart';
import '../../widgets/auth/signup_textfield.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _comment = TextEditingController();
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
        title: Text("Contact Us", style: appBarStyle(screenSize)),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.03),
              Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.04,
                    right: screenSize.width * 0.04),
                child: Text(
                  "If you have questions leave us a message down here, someone from our team will get back to you shortly.",
                  style: TextStyle(
                      fontFamily: AppFonts.medium,
                      fontSize: AppTextSize.propertyNameSize),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Center(
                child: SignUpTextFieldWidget(
                  hintText: "Full Name",
                  textInputType: TextInputType.name,
                  // prefixIcon: Icons.person,
                  controller: _fullName,

                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 0),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Center(
                child: SignUpTextFieldWidget(
                  hintText: "Email",
                  textInputType: TextInputType.name,
                  // prefixIcon: Icons.person,
                  controller: _email,

                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 0),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Center(
                child: SignUpTextFieldWidget(
                  hintText: "Phone",
                  textInputType: TextInputType.name,
                  // prefixIcon: Icons.person,
                  controller: _phone,

                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 0),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Center(
                child: Container(
                  // height: 90,
                  width: screenSize.width * 0.92,
                  decoration: BoxDecoration(
                    color: Provider.of<DarkThemeProvider>(context).isDarkMode
                        ? AppColor.darkBackground
                        : AppColor.lightBackground,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    controller: _comment,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, top: 10),
                      border: InputBorder.none,
                      hintText: "Hy there, i would like to ...",
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: screenSize.width * 0.92,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColorCustom,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Send Comment",
                    style: TextStyle(
                        fontSize: AppTextSize.propertyNameSize + 1,
                        color: Colors.white,
                        fontFamily: AppFonts.semiBold),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
