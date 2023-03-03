import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/app_const.dart';
import '../../utils/app_textStyle.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  ThemeManager _themeManager = ThemeManager();
  AuthController _authController = AuthController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: _themeManager.getWhiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // -------------- change password intro -------------
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    left: width * 0.04,
                    top: height * 0.03,
                    bottom: height * 0.055),
                height: height * 0.3,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/resetPassword.png"),
                )),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: width * 0.04,
                    ),
                    Text(
                      "Back",
                      style: FontUtils.promptRegularStyle.copyWith(),
                    )
                  ]),
                ),
              ),
              Text(
                "Reset or Change of Password",
                style: FontUtils.promptSemiBoldStyle
                    .copyWith(fontSize: width * 0.055),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: height * 0.01, left: width * 0.1, right: width * 0.1),
                child: Text(
                  "Your new password must be different from previous used passwords.",
                  textAlign: TextAlign.center,
                  style: FontUtils.promptRegularStyle.copyWith(
                      fontSize: width * 0.04,
                      color: _themeManager.getGreyFontColor),
                ),
              ),

              /// ------------------ password section ----------------
              Container(
                margin: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -------------- new password section ------------
                    Container(
                      margin: EdgeInsets.only(
                          top: height * 0.02, bottom: height * 0.005),
                      child: Text(
                        "New Password",
                        style: FontUtils.promptRegularStyle.copyWith(
                            fontSize: width * 0.035,
                            color: _themeManager.getGreyFontColor),
                      ),
                    ),
                    CustomTextField(
                      isActive: true,
                      numberOfLine: 1,
                      hintText: "New Password",
                      controller: _passwordController,
                      obscureText: true,
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

                    // -------------- verify password section ------------

                    Container(
                      margin: EdgeInsets.only(
                          top: height * 0.02, bottom: height * 0.005),
                      child: Text(
                        "Confirm New Password",
                        style: FontUtils.promptRegularStyle.copyWith(
                            fontSize: width * 0.035,
                            color: _themeManager.getGreyFontColor),
                      ),
                    ),
                    CustomTextField(
                      isActive: true,
                      numberOfLine: 1,
                      hintText: "Confirm New Password",
                      controller: _retypePassword,
                      obscureText: true,
                      obSecure: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: () {
                        if (_retypePassword.text == "") {
                          return "Please retype your password";
                        } else if (_retypePassword.text !=
                            _passwordController.text) {
                          return "Password not match";
                        } else {
                          return null;
                        }
                      },
                    ),

                    // -------------- submit button -------------
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          _authController
                              .changePasswordController(
                                  _passwordController.text)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: height * 0.03, bottom: height * 0.02),
                          child: CustomButton(title: "Save Password")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
