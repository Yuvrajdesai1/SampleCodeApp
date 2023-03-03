import 'package:flutter/material.dart';
import 'package:nftapp/controllers/auth_controller.dart';
import 'package:nftapp/screens/auth_screen/login_screen.dart';

import '../../utils/app_const.dart';
import '../../utils/app_textStyle.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ThemeManager _themeManager = ThemeManager();
  final _formKey = GlobalKey<FormState>();

  AuthController _authController = AuthController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  bool isChecked = false;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ------------------ signUp intro -----------------

                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      EdgeInsets.only(left: width * 0.04, top: height * 0.03),
                  height: height * 0.2,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/signup.png"),
                          fit: BoxFit.fitHeight)),
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
                  "Create an Account",
                  style: FontUtils.promptSemiBoldStyle
                      .copyWith(fontSize: width * 0.055),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.06,
                      right: width * 0.06),
                  child: Text(
                    "Chose your credentials and sign up",
                    textAlign: TextAlign.center,
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04,
                        color: _themeManager.getGreyFontColor),
                  ),
                ),

                /// ----------------- user details ------------------
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ------------------- first name section -----------------
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

                      // ------------------- last name section -----------------

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

                      // ------------------- email address section -----------------

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

                      // ------------------- password section -----------------

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

                      // ------------------- term and condition section -----------------

                      Container(
                        margin: EdgeInsets.only(top: height * 0.015),
                        child: Row(children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                activeColor: _themeManager.getPrimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: isChecked,
                                onChanged: (_) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                }),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "By signing up, you’re agree to our ",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.032,
                                    color: _themeManager.getGreyFontColor),
                              ),
                              Text(
                                "Terms & conditions and Privacy Policy",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.032,
                                    height: height * 0.0015,
                                    color: _themeManager.getPrimaryColor),
                              ),
                            ],
                          ),
                        ]),
                      ),

                      // ------------------- signup button -------------------
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate() &&
                              isChecked == true) {
                            bool response =
                                await _authController.signupController(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text);
                            if (response == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            } else {
                              print("error in signup");
                            }
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: height * 0.025, bottom: height * 0.02),
                            child: CustomButton(title: "Sign up")),
                      ),

                      // ------------------- login  button ---------------
                      Container(
                        margin: EdgeInsets.only(top: height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: width * 0.02),
                              child: Text(
                                "Already have an account?",
                                style: FontUtils.promptRegularStyle.copyWith(
                                    fontSize: width * 0.04,
                                    color: _themeManager.getBlackColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                "Login",
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
