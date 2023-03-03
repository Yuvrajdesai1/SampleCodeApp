import 'package:flutter/material.dart';
import 'package:nftapp/controllers/auth_controller.dart';
import 'package:nftapp/screens/auth_screen/login_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/app_const.dart';
import '../../utils/app_textStyle.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  ThemeManager _themeManager = ThemeManager();

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
                // ------------------ Forget password intro -----------------
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      left: width * 0.04,
                      bottom: height * 0.1,
                      top: height * 0.03),
                  height: height * 0.3,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/forgetPassword.png"))),
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
                  "Forgot Password",
                  style: FontUtils.promptSemiBoldStyle
                      .copyWith(fontSize: width * 0.055),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.06,
                      right: width * 0.06),
                  child: Text(
                    "Don’t worry! It Happens. Please enter the address associated with your account.",
                    textAlign: TextAlign.center,
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04,
                        color: _themeManager.getGreyFontColor),
                  ),
                ),

                // ------------------ email field and send otp button --------------------
                Container(
                  margin:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            Provider.of<AuthController>(context, listen: false)
                                .resetPasswordController(_emailController.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: height * 0.06, bottom: height * 0.02),
                            child: CustomButton(title: "Send OTP")),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: height * 0.01),
                              child: Text(
                                "Back to Login",
                                style: FontUtils.promptSemiBoldStyle.copyWith(
                                    fontSize: width * 0.04,
                                    color: _themeManager.getPinkFontColor),
                              ),
                            ),
                          ),
                        ],
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
