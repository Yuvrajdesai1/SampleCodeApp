import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nftapp/controllers/auth_controller.dart';
import 'package:nftapp/screens/auth_screen/forget_password_screen.dart';
import 'package:nftapp/screens/auth_screen/signup_screen.dart';
import 'package:nftapp/screens/dashboard/dashboard_screen.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  ThemeManager _themeManager = ThemeManager();

  AuthController _authController = AuthController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                // ------------------ login intro -----------------

                Container(
                  margin: EdgeInsets.only(bottom: height * 0.035),
                  height: height * 0.3,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/login.png"))),
                ),
                Text(
                  "Welcome back!",
                  style: FontUtils.promptSemiBoldStyle
                      .copyWith(fontSize: width * 0.055),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.06,
                      right: width * 0.06),
                  child: Text(
                    "Use your credentials below and login to your account",
                    textAlign: TextAlign.center,
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04,
                        color: _themeManager.getGreyFontColor),
                  ),
                ),

                /// --------------- login details ------------------
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ------------------ email section-----------------
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.055, bottom: height * 0.005),
                        child: Text(
                          "Email Address",
                          style: FontUtils.promptRegularStyle.copyWith(
                              fontSize: width * 0.035,
                              color: _themeManager.getGreyFontColor),
                        ),
                      ),
                      CustomTextField(
                        isActive: true,
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

                      // ------------------ password section-----------------

                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.025, bottom: height * 0.005),
                        child: Text(
                          "Password",
                          style: FontUtils.promptRegularStyle.copyWith(
                              fontSize: width * 0.035,
                              color: _themeManager.getGreyFontColor),
                        ),
                      ),
                      CustomTextField(
                        isActive: true,
                        numberOfLine: 1,
                        hintText: "Password",
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

                      // ------------------ login button ------------------
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            bool response =
                                await _authController.loginController(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                            if (response == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashBoardScreen(),
                                  ));
                            } else {
                              print("please enter valid credentials");
                            }
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: height * 0.035, bottom: height * 0.02),
                            child: CustomButton(title: "Login")),
                      ),

                      // ------------------ forget password button ------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ));
                            },
                            child: Text(
                              "Forget Password?",
                              style: FontUtils.promptSemiBoldStyle.copyWith(
                                  fontSize: width * 0.04,
                                  color: _themeManager.getPrimaryColor),
                            ),
                          ),
                        ],
                      ),

                      // ------------------ signUp button ---------------
                      Container(
                        margin: EdgeInsets.only(top: height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: width * 0.02),
                              child: Text(
                                "You don’t have an account?",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.04,
                                    color: _themeManager.getBlackColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ));
                              },
                              child: Text(
                                "Signup",
                                style: FontUtils.promptMediumStyle.copyWith(
                                    fontSize: width * 0.04,
                                    color: _themeManager.getPinkFontColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
