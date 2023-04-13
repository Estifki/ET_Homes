import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_project/services/profile.dart';
import 'package:real_estate_project/services/provider/dark_theme.dart';
import 'package:real_estate_project/utility/toast/show_message.dart';
import 'package:real_estate_project/widgets/auth/signup_textfield.dart';

import '../../const/const.dart';
import '../../services/auth/auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../utility/bottom_nav.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  var _pickedImage;
  String _picUrl = "";
  late String _userId;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _userId = Provider.of<AuthProvider>(context, listen: false).userId!;
  }

  void pickImage() async {
    XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      _pickedImage = File(image.path);
      setState(() {});
    }
  }

  Future<void> uploadProfile() async {
    var res = _storage.ref().child("Users-Profile").child("$_userId.jpg");
    await res.putFile(_pickedImage);
    _picUrl = await res.getDownloadURL();
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
        title: Text("Update Profile", style: appBarStyle(screenSize)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: screenSize.height * 0.05),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => pickImage(),
                  child: _pickedImage == null
                      ? Container(
                          height: screenSize.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/update_profile.png",
                                fit: BoxFit.cover,
                              )),
                        )
                      : Container(
                          height: screenSize.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                            image: DecorationImage(
                              image: FileImage(_pickedImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                SizedBox(height: screenSize.height * 0.08),
                Center(
                  child: SignUpTextFieldWidget(
                    hintText: "First name",
                    textInputType: TextInputType.name,
                    // prefixIcon: Icons.person,
                    controller: _firstNameController,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility, size: 0),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SignUpTextFieldWidget(
                  hintText: "Last name",
                  textInputType: TextInputType.name,
                  // prefixIcon: Icons.person,
                  controller: _lastNameController,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 0),
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
                            "Update",
                            style: TextStyle(
                                fontSize: AppTextSize.propertyNameSize + 1,
                                color: Colors.white,
                                fontFamily: AppFonts.semiBold),
                          ),
                        ),
                      ),
              ]),
        ),
      ),
    );
  }

  validateUpdate() {
    if (_pickedImage == null) {
      showErrorMessage(220, context, "Image not Picked");
    } else {
      try {
        setState(() {
          _isloading = true;
        });
        uploadProfile().then((_) {
          ProfileApi.updateUserProfile(_userId, _firstNameController.text,
                  _lastNameController.text, _picUrl)
              .then(
            (value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BottomNavagationScreen(
                  selectedIndex: 3,
                ),
              ),
            ),
          );
        });
      } catch (_) {
        rethrow;
      }
    }
  }
}
