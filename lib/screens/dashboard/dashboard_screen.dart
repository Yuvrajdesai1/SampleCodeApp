import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:nftapp/screens/dashboard/user_products_screen.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth_controller.dart';
import 'all_products_screen.dart';
import 'for_sell_screen.dart';
import 'add_Product_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 2;
  List screens = [
    AllProductsScreen(),
    UserProducts(),
    SearchScreen(),
  ];
  late SharedPreferences prefs;
  late AuthController authController;

  ThemeManager _themeManager = ThemeManager();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    authController = Provider.of<AuthController>(context, listen: true);

    return Scaffold(
      /// ---------- floating action button ---------
      floatingActionButton: FloatingActionButton(
          backgroundColor: _themeManager.getPrimaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => addIdea(),
                ));
          }),

      /// -------------- body section  ------------
      body: screens[selectedIndex],

      /// -------------- bottom navigation bar section -------------
      bottomNavigationBar: Container(
        color: _themeManager.getWhiteColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ----------- story page section ----------
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      height: height * 0.004,
                      width: width * 0.2,
                      color: selectedIndex == 0
                          ? _themeManager.getPrimaryColor
                          : _themeManager.getWhiteColor,
                    ),
                    Image.asset(
                      "assets/icons/story.png",
                      color: selectedIndex == 0
                          ? _themeManager.getPrimaryColor
                          : _themeManager.getGreyFontColor,
                    ),
                    Text(
                      "Story",
                      style: FontUtils.promptRegularStyle.copyWith(
                        color: selectedIndex == 0
                            ? _themeManager.getPrimaryColor
                            : _themeManager.getGreyFontColor,
                      ),
                    )
                  ],
                )),
            // ----------- buy page section -----------
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      height: height * 0.004,
                      width: width * 0.2,
                      color: selectedIndex == 1
                          ? _themeManager.getPrimaryColor
                          : _themeManager.getWhiteColor,
                    ),
                    Image.asset(
                      "assets/icons/buy.png",
                      color: selectedIndex == 1
                          ? _themeManager.getPrimaryColor
                          : _themeManager.getGreyFontColor,
                    ),
                    Text(
                      "Buy",
                      style: FontUtils.promptRegularStyle.copyWith(
                        color: selectedIndex == 1
                            ? _themeManager.getPrimaryColor
                            : _themeManager.getGreyFontColor,
                      ),
                    )
                  ],
                )),
            // ----------- sell page section -----------
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      height: height * 0.004,
                      width: width * 0.2,
                      color: selectedIndex == 2
                          ? _themeManager.getPrimaryColor
                          : _themeManager.getWhiteColor,
                    ),
                    Image.asset(
                      "assets/icons/sell.png",
                      color: selectedIndex == 2
                          ? _themeManager.getPrimaryColor
                          : _themeManager.getGreyFontColor,
                    ),
                    Text(
                      "Sell",
                      style: FontUtils.promptRegularStyle.copyWith(
                        color: selectedIndex == 2
                            ? _themeManager.getPrimaryColor
                            : _themeManager.getGreyFontColor,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future getUserData() async {
    prefs = await SharedPreferences.getInstance();
    var response =
        await authController.getUserDataController().then((value) async {
      await Future.delayed(Duration(seconds: 2));
      log(authController.userModel.firstName!);
    });
    await prefs.setString(
        Session().firstName, authController.userModel.firstName!);
    await prefs.setString(
        Session().buyerImage, authController.userModel.profilePicture!);
  }
}
