import 'package:flutter/material.dart';
import 'package:nftapp/screens/user_screen/setting_screen.dart';
import 'package:nftapp/utils/app_textStyle.dart';

import '../../utils/app_const.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/cuatom_appbar.dart';
import '../../widgets/prefix_icon.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  _TermsAndConditionScreenState createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  ThemeManager _themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _themeManager.getWhiteColor,

      /// ----------- appbar ---------------
      appBar: CustomAppBar(
          title: "Terms and condition",
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
          )),

      /// ------------ terms and condition section ---------------
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
                top: height * 0.01,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.01),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04, height: height * 0.002),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04, height: height * 0.002),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04, height: height * 0.002),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04, height: height * 0.002),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: FontUtils.promptRegularStyle.copyWith(
                        fontSize: width * 0.04, height: height * 0.002),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
