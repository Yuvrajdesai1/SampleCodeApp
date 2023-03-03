import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nftapp/screens/dashboard/change_password_screen.dart';
import 'package:nftapp/screens/user_screen/setting_screen.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/app_const.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/cuatom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/prefix_icon.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;
  ThemeManager _themeManager = ThemeManager();

  final ImagePicker _picker = ImagePicker();

  File? _image;
  String? image;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  // --------------------- image picker ----------------
  getProfileImageFromGallery() async {
    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    setState(() {
      _image = File(image!.path);
    });
    Provider.of<AuthController>(context, listen: false)
        .addProfileImageController(_image!, context,
            Provider.of<AuthController>(context, listen: false).userModel);
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    isLoading = Provider.of<AuthController>(context, listen: true).isLoading;
    _firstNameController.text =
        Provider.of<AuthController>(context, listen: true).userModel.firstName!;
    _lastNameController.text =
        Provider.of<AuthController>(context, listen: true).userModel.lastName!;
    _emailController.text =
        Provider.of<AuthController>(context, listen: true).userModel.email!;
    _passwordController.text = "000000";
    image = Provider.of<AuthController>(context, listen: true)
            .userModel
            .profilePicture ??
        null;
    return Scaffold(
      backgroundColor: _themeManager.getWhiteColor,

      /// ------------ appbar ---------------
      appBar: CustomAppBar(
        title: "Profile",
        prefixIcon: PrifixIcon(),
        actions: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ));
          },
          child: Container(
            margin: EdgeInsets.only(right: width * 0.02),
            child: Icon(Icons.settings),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<AuthController>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // ------------- profile image section ---------------
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                            top: height * 0.04,
                            bottom: height * 0.004),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              getProfileImageFromGallery();
                            },
                            child: Column(
                              children: [
                                value.userModel.profilePicture != null
                                    ? Container(
                                        height: width * 0.3,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(width),
                                          border: Border.all(
                                              color:
                                                  _themeManager.getPrimaryColor,
                                              width: width * 0.006),
                                          image: DecorationImage(
                                            image: NetworkImage(value
                                                .userModel.profilePicture!),
                                            fit: BoxFit
                                                .cover, //change image fill type
                                          ),
                                        ),
                                        alignment: AlignmentDirectional.center,
                                      )
                                    : Icon(
                                        Icons.supervised_user_circle_outlined,
                                        size: 100,
                                      ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: height * 0.015,
                                      bottom: height * 0.01),
                                  child: Text(
                                    "Upload Profile",
                                    style: FontUtils.promptMediumStyle.copyWith(
                                        color: _themeManager.getPrimaryColor,
                                        fontSize: width * 0.04),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Divider(
                        color: _themeManager.getLightGreyBorderColor,
                        thickness: height * 0.008,
                      ),

                      // ------------- user first name section ---------------

                      Container(
                        margin: EdgeInsets.only(
                          left: width * 0.04,
                          right: width * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, bottom: height * 0.005),
                              child: Text(
                                "First Name",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.035,
                                    color: _themeManager.getGreyFontColor),
                              ),
                            ),
                            CustomTextField(
                              isActive: true,
                              numberOfLine: 1,
                              hintText: "First Name",
                              controller: _firstNameController,
                              obscureText: false,
                              obSecure: false,
                              keyboardType: TextInputType.visiblePassword,
                              validator: () {
                                if (_firstNameController.text == "") {
                                  return "Please enter your first name";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            // ------------- user last name section ---------------

                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, bottom: height * 0.005),
                              child: Text(
                                "Last Name",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.035,
                                    color: _themeManager.getGreyFontColor),
                              ),
                            ),
                            CustomTextField(
                              isActive: true,
                              numberOfLine: 1,
                              hintText: "Last Name",
                              controller: _lastNameController,
                              obscureText: false,
                              obSecure: false,
                              keyboardType: TextInputType.visiblePassword,
                              validator: () {
                                if (_lastNameController.text == "") {
                                  return "Please enter your last name";
                                } else {
                                  return null;
                                }
                              },
                            ),

                            // ------------- user email section ---------------

                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, bottom: height * 0.005),
                              child: Text(
                                "Email Address",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.035,
                                    color: _themeManager.getGreyFontColor),
                              ),
                            ),
                            CustomTextField(
                              isActive: false,
                              numberOfLine: 1,
                              hintText: "Email Address",
                              controller: _emailController,
                              obscureText: false,
                              obSecure: false,
                              keyboardType: TextInputType.emailAddress,
                              validator: () {
                                if (_emailController.text == "") {
                                  return "Please enter your email address";
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailController.text)) {
                                  return null;
                                } else {
                                  return "Please enter valid email address";
                                }
                              },
                            ),

                            // ------------- user password section ---------------

                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.02, bottom: height * 0.005),
                              child: Text(
                                "Password",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.035,
                                    color: _themeManager.getGreyFontColor),
                              ),
                            ),
                            CustomTextField(
                              isActive: false,
                              numberOfLine: 1,
                              hintText: "Password",
                              controller: _passwordController,
                              obscureText: false,
                              obSecure: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: () {
                                if (_passwordController.text == "") {
                                  return "Please enter your password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      // --------------- change password button ---------------
                      Container(
                        margin: EdgeInsets.only(
                            right: width * 0.04, top: height * 0.008),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangePassword(),
                                      ));
                                },
                                child: Text(
                                  "Change Password",
                                  style: FontUtils.promptRegularStyle.copyWith(
                                      fontSize: width * 0.035,
                                      color: _themeManager.getPrimaryColor),
                                ),
                              ),
                            ]),
                      ),

                      // ------------- save button --------------
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            value.EditProfileController(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: height * 0.03,
                                bottom: height * 0.01,
                                right: width * 0.04,
                                left: width * 0.04),
                            child: CustomButton(title: "Save Profile")),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // -------- get user data from server ---------
  getUserData() async {
    await Provider.of<AuthController>(context, listen: false)
        .getUserDataController();
  }
}
