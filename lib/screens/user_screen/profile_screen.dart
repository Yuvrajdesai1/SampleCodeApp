import 'package:flutter/material.dart';
import 'package:nftapp/controllers/auth_controller.dart';
import 'package:nftapp/screens/user_screen/setting_screen.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../utils/app_const.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/cuatom_appbar.dart';
import '../../widgets/prefix_icon.dart';
import '../auth_screen/login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ThemeManager _themeManager = ThemeManager();

  bool isLoading = true;

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
    return Scaffold(
      backgroundColor: _themeManager.getWhiteColor,

      /// -------------- appbar --------------
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
          )),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<AuthController>(
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: width,
                        height: height * 0.2,
                        color: _themeManager.getPrimaryColor,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.025),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: height * 0.045, bottom: height * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.025),
                            color: _themeManager.getWhiteColor,
                          ),
                          width: width * 0.92,
                          child: Column(
                            children: [
                              // -------------- user profile picture -------------
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
                                          image: NetworkImage(
                                              value.userModel.profilePicture!),
                                          fit: BoxFit
                                              .cover, //change image fill type
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.supervised_user_circle_outlined,
                                      size: 100,
                                    ),

                              // -------------- user first name section -----------
                              Container(
                                margin: EdgeInsets.only(top: height * 0.03),
                                child: profileField("First Name",
                                    value.userModel.firstName!, true),
                              ),
                              // -------------- user last name section -----------

                              profileField(
                                  "Last Name", value.userModel.lastName!, true),
                              // -------------- user email section -----------

                              profileField("E-mail Address",
                                  value.userModel.email!, true),

                              // -------------- user phone number section -----------

                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: width * 0.04,
                                          right: width * 0.04,
                                          top: height * 0.02,
                                          bottom: height * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              "Phone Number",
                                              style: FontUtils.promptMediumStyle
                                                  .copyWith(
                                                      fontSize: width * 0.045),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.33,
                                            child: Text(
                                              value.userModel.phoneNumber == ""
                                                  ? "Add"
                                                  : value
                                                      .userModel.phoneNumber!,
                                              textAlign:
                                                  value.userModel.phoneNumber ==
                                                          ""
                                                      ? TextAlign.end
                                                      : TextAlign.start,
                                              style:
                                                  FontUtils.promptRegularStyle.copyWith(
                                                      fontSize: width * 0.04,
                                                      color: value.userModel
                                                                  .phoneNumber ==
                                                              ""
                                                          ? _themeManager
                                                              .getPinkFontColor
                                                          : _themeManager
                                                              .getGreyFontColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: _themeManager.getBlackColor,
                                    ),
                                  ],
                                ),
                              ),

                              // -------------- user password section -----------

                              profileField("Password", "*****", false),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // -------------- edit profile and logout button ----------
                    Positioned(
                      bottom: 10,
                      left: width * 0.04,
                      right: width * 0.04,
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ));
                          },
                          child: Container(
                            child: CustomButton(title: "Edit Profile"),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Provider.of<AuthController>(context,
                                      listen: false)
                                  .logOutController();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 5,
                              child: Container(
                                  margin: EdgeInsets.only(top: height * 0.004),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    width: width,
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                _themeManager.getPrimaryColor),
                                        color: _themeManager.getWhiteColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Logout",
                                      style: FontUtils.promptMediumStyle
                                          .copyWith(
                                              fontSize: width * 0.045,
                                              color: _themeManager
                                                  .getPrimaryColor),
                                    ),
                                  )),
                            )),
                      ]),
                    )
                  ],
                );
              },
            ),
    );
  }

  // -------------- get user data from server -------------
  getUserData() async {
    await Provider.of<AuthController>(context, listen: false)
        .getUserDataController();
  }

  // -------------- profile field widget -------------
  Widget profileField(title, data, isDivider) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: width * 0.04,
                right: width * 0.04,
                top: height * 0.02,
                bottom: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.45,
                  child: Text(
                    title,
                    style: FontUtils.promptMediumStyle
                        .copyWith(fontSize: width * 0.045),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  data,
                  style: FontUtils.promptRegularStyle.copyWith(
                      fontSize: width * 0.04,
                      color: _themeManager.getGreyFontColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          isDivider
              ? Divider(
                  color: _themeManager.getBlackColor,
                )
              : Container(),
        ],
      ),
    );
  }
}
