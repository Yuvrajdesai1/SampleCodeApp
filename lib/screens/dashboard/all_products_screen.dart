import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nftapp/screens/dashboard/product_detail_screen.dart';
import 'package:nftapp/screens/user_screen/setting_screen.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';
import '../../widgets/cuatom_appbar.dart';
import 'idea_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  bool isLoading = true;
  ThemeManager _themeManager = ThemeManager();

  // -------------- date format -------------
  DateFormat formattedDate = DateFormat('dd MMM');

  @override
  void initState() {
    getUserProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLoading = Provider.of<ProductController>(context, listen: true).isLoading;

    return Scaffold(
      backgroundColor: _themeManager.getGreyBackgroundColor,

      /// ------------- appbar ------------
      appBar: CustomAppBar(
        actions:     GestureDetector(
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
          title: "Home",
          prefixIcon: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IdeaScreen(),
                ),
              );
            },
            child: Image.asset(
              "assets/icons/bulb.png",
              color: _themeManager.getWhiteColor,
            ),
          )),
      body: Consumer<ProductController>(
        builder: (context, value, child) {
          return isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      Container(height: height * 0.01),
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                      top: height * 0.02),
                  itemCount: value.allProducts!.length,
                  itemBuilder: (context, index) {

                    // ------------- product section ----------
                    return Card(
                      elevation: 12,
                      shadowColor: _themeManager.getGreyBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03)),
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                    prodId: value.allProducts![index].prodId!,
                                    isLikeScreen: true),
                              ));
                        },
                        child: Container(
                          height: height * 0.3,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            color: _themeManager.getWhiteColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: height * 0.18,
                                  width: width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(width * 0.03),
                                        topRight:
                                            Radius.circular(width * 0.03)),
                                    child: Image.network(
                                      value.allProducts![index].imageName!,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * 0.04,
                                    top: height * 0.01,
                                    right: width * 0.04),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value.allProducts![index].title
                                          .toString(),
                                      style: FontUtils.promptSemiBoldStyle
                                          .copyWith(fontSize: width * 0.045),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: height * 0.03,
                                      width: width * 0.32,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.01),
                                          color:
                                              _themeManager.getPinkFontColor),
                                      child: Text(
                                        "Last Update " +
                                            formattedDate.format(DateTime.parse(
                                                value.allProducts![0]
                                                    .lastBuyingTime!)),
                                        style: FontUtils.promptRegularStyle
                                            .copyWith(
                                                fontSize: width * 0.03,
                                                color: _themeManager
                                                    .getWhiteColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.01,
                                    left: width * 0.04,
                                    right: width * 0.04),
                                child: Text(
                                  value.allProducts![index].description!,
                                  style: FontUtils.promptRegularStyle.copyWith(
                                      height: height * 0.0015,
                                      color: _themeManager.getGreyFontColor,
                                      fontSize: width * 0.032),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    );
                  });
        },
      ),
    );
  }


  // -------------- get user product from server --------------
  getUserProduct() async {
    await Provider.of<ProductController>(context, listen: false)
        .getAllProductController();
  }
}
