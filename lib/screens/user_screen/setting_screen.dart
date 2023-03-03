import 'package:flutter/material.dart';
import 'package:nftapp/screens/user_screen/profile_screen.dart';
import 'package:nftapp/screens/user_screen/privacy_policy_screen.dart';
import 'package:nftapp/screens/user_screen/terms-and_condition_screen.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';

import '../../widgets/cuatom_appbar.dart';
import '../../widgets/prefix_icon.dart';
import '../dashboard/change_password_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ThemeManager _themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _themeManager.getWhiteColor,

      /// ------------- appbar --------------
      appBar: CustomAppBar(
          title: "Settings", prefixIcon: PrifixIcon(), actions: Container()),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.02),
            child: Text(
              "Account settings",
              style: FontUtils.promptRegularStyle
                  .copyWith(color: _themeManager.getGreyFontColor),
            ),
          ),

          // ---------- profile information section --------------
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
            },
            child: settingRow(
                title: "Profile Information",
                subTitle: "Name, Email, Security",
                image: "assets/icons/user.png"),
          ),

          // ---------- change password section --------------

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ));
            },
            child: settingRow(
                title: "Change Password",
                subTitle: "Change your current password",
                image: "assets/icons/lock.png"),
          ),

          // ---------- notification section --------------

          Container(
            margin: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.02),
            child: Text(
              "Notification settings",
              style: FontUtils.promptRegularStyle
                  .copyWith(color: _themeManager.getGreyFontColor),
            ),
          ),
          settingRow(
              title: "Push Notification",
              subTitle: "New Contracts Sign or Send",
              image: "assets/icons/bell.png"),

          // ---------- general information section --------------

          Container(
            margin: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.02),
            child: Text(
              "General",
              style: FontUtils.promptRegularStyle
                  .copyWith(color: _themeManager.getGreyFontColor),
            ),
          ),

          // ---------- change language section --------------

          settingRow(
              title: "Change Language",
              subTitle: "English",
              image: "assets/icons/language.png"),

          // ---------- send feedback section --------------

          settingRow(
              title: "Send Feedback",
              subTitle: "Share your thought",
              image: "assets/icons/mail.png"),

          // ---------- privacy policy section --------------

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ));
            },
            child: settingRow(
                title: "Privacy Policy",
                subTitle: "Generate Lorem Ipsum place",
                image: "assets/icons/eye-off.png"),
          ),

          // ---------- term and condition section --------------

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionScreen(),
                  ));
            },
            child: settingRow(
                title: "Term and condition",
                subTitle: "Generate Lorem Ipsum place",
                image: "assets/icons/doc.png"),
          ),

          // ---------- version name section --------------

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.02),
            child: Text(
              "VERSION 20.30 (201817)",
              style: FontUtils.promptRegularStyle
                  .copyWith(color: _themeManager.getGreyFontColor),
            ),
          ),

        ]),
      ),
    );
  }


  // ---------- setting row ----------
  Widget settingRow(
      {required String image,
      required String title,
      required String subTitle}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: width * 0.04, right: width * 0.04, bottom: height * 0.006),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: width * 0.04),
                  padding: EdgeInsets.all(width * 0.015),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _themeManager.getLightPrimaryColor),
                  child: Image.asset(image)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontUtils.promptMediumStyle
                        .copyWith(fontSize: width * 0.04),
                  ),
                  Text(subTitle,
                      style: FontUtils.promptRegularStyle.copyWith(
                          height: height * 0.002,
                          fontSize: width * 0.035,
                          color: _themeManager.getGreyFontColor)),
                ],
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
