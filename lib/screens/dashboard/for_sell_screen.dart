import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nftapp/screens/dashboard/payment_screen.dart';
import 'package:nftapp/screens/dashboard/product_detail_screen.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';
import '../../utils/app_const.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/cuatom_appbar.dart';
import '../../widgets/cusom_search.dart';
import '../../widgets/prefix_icon.dart';
import '../user_screen/setting_screen.dart';
import 'idea_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ThemeManager _themeManager = ThemeManager();

  bool isLoading = true;
  bool isSearching = false;

  TextEditingController _searchController = TextEditingController();

  int? defaultChoiceIndex;
  List<String> _choicesList = [
    'Lego batmobile',
    'Batman batipato',
    'Teddy',
    "Toy",
    "Minion criminal"
  ];

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    isLoading = Provider.of<ProductController>(context, listen: true).isLoading;
    isSearching =
        Provider.of<ProductController>(context, listen: true).isSearching;

    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductController>(context, listen: false)
            .stopSearchingController();
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        backgroundColor: _themeManager.getGreyBackgroundColor,

        /// ----------- appbar ---------------
        appBar: CustomAppBar(
            title: "For sale",
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
        body: Consumer<ProductController>(
          builder: (context, value, child) {
            return isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      // ---------------- search bar section -----------------
                      Container(
                        padding: EdgeInsets.only(
                            bottom: height * 0.01,
                            left: width * 0.03,
                            right: width * 0.03),
                        color: _themeManager.getPrimaryColor,
                        child: CustomSearch(
                          controller: _searchController,
                          onChanged: () {
                            value.searchProductController(
                                _searchController.text);
                            setState(() {});
                          },
                          hintText: "Search sale",
                          backgroundColor: _themeManager.getWhiteColor,
                        ),
                      ),

                      // ---------------- search history section ---------------
                      Container(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            bottom: height * 0.01,
                            left: width * 0.04,
                            right: width * 0.04),
                        color: _themeManager.getWhiteColor,
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Search History",
                                  style: FontUtils.promptMediumStyle
                                      .copyWith(fontSize: width * 0.04),
                                ),
                                Image.asset(
                                  "assets/icons/delete.png",
                                  color: _themeManager.getBlackColor,
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: width * 0.8,
                                child: Wrap(
                                  spacing: 8,
                                  children: List.generate(_choicesList.length,
                                      (index) {
                                    return ChoiceChip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      labelPadding: EdgeInsets.all(2.0),
                                      label: Text(_choicesList[index],
                                          style: FontUtils.promptRegularStyle
                                              .copyWith()),

                                      selected: defaultChoiceIndex == index,
                                      selectedColor: Colors.deepPurple,
                                      onSelected: (value) {
                                        setState(() {
                                          _searchController.text =
                                              _choicesList[index];
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),

                      // ---------------- filter product section ---------------
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                            top: height * 0.02),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All sale (${isSearching ? value.searchProduct!.length : value.allProducts!.length})",
                                style: FontUtils.promptMediumStyle.copyWith(),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "Short by:",
                                    style: FontUtils.promptRegularStyle
                                        .copyWith(
                                            color: _themeManager.getBlackColor),
                                    children: [
                                      TextSpan(
                                        text: " A-Z",
                                        style: FontUtils.promptRegularStyle
                                            .copyWith(
                                                color: _themeManager
                                                    .getPinkFontColor),
                                      ),
                                    ]),
                              )
                            ]),
                      ),

                      // --------------- product section -------------
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: height * 0.02),
                          itemCount: isSearching
                              ? value.searchProduct!.length
                              : value.allProducts!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: width * 0.04,
                                right: width * 0.04,
                                bottom: height * 0.006,
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _themeManager.getWhiteColor,
                                      borderRadius:
                                          BorderRadius.circular(width * 0.025)),
                                  padding: EdgeInsets.only(
                                      left: width * 0.02,
                                      right: width * 0.02,
                                      top: height * 0.015,
                                      bottom: height * 0.015),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.02),
                                        child: Image.network(
                                          isSearching
                                              ? value.searchProduct![index]
                                                  .imageName!
                                              : value.allProducts![index]
                                                  .imageName!,
                                          height: height * 0.08,
                                          width: height * 0.08,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: width * 0.02,
                                            right: width * 0.01),
                                        width: width * 0.57,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              isSearching
                                                  ? value.searchProduct![index]
                                                      .title!
                                                  : value
                                                      .allProducts![index].title
                                                      .toString(),
                                              style: FontUtils
                                                  .promptSemiBoldStyle
                                                  .copyWith(
                                                      height: height * 0.0015,
                                                      fontSize: width * 0.04),
                                            ),
                                            Text(
                                              isSearching
                                                  ? value.searchProduct![index]
                                                      .description!
                                                  : value.allProducts![index]
                                                      .description
                                                      .toString(),
                                              style: FontUtils
                                                  .promptSemiBoldStyle
                                                  .copyWith(
                                                      height: height * 0.0015,
                                                      fontSize: width * 0.035,
                                                      color: _themeManager
                                                          .getGreyFontColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            isSearching
                                                ? value.searchProduct![index]
                                                            .price !=
                                                        null
                                                    ? Text(
                                                        "\$${value.searchProduct![index].price!}",
                                                        style: FontUtils
                                                            .promptSemiBoldStyle
                                                            .copyWith(
                                                                height: height *
                                                                    0.002,
                                                                fontSize:
                                                                    width *
                                                                        0.045,
                                                                color: _themeManager
                                                                    .getPinkFontColor),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    : Container()
                                                : value.allProducts![index]
                                                            .price !=
                                                        null
                                                    ? Text(
                                                        "\$${value.allProducts![index].price}",
                                                        style: FontUtils
                                                            .promptSemiBoldStyle
                                                            .copyWith(
                                                                height: height *
                                                                    0.002,
                                                                fontSize:
                                                                    width *
                                                                        0.045,
                                                                color: _themeManager
                                                                    .getPinkFontColor),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    : Container(),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen(
                                                prodId: isSearching
                                                    ? value
                                                        .searchProduct![index]
                                                        .prodId!
                                                    : value.allProducts![index]
                                                        .prodId!,
                                                isLikeScreen: false,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          isSearching
                                              ? value.searchProduct![index]
                                                          .price ==
                                                      null
                                                  ? "assets/icons/refreshRound.png"
                                                  : "assets/icons/dollerRound.png"
                                              : value.allProducts![index]
                                                          .price ==
                                                      null
                                                  ? "assets/icons/refreshRound.png"
                                                  : "assets/icons/dollerRound.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  // -------------------- get products from server ---------------
  getAllProduct() async {
    await Provider.of<ProductController>(context, listen: false)
        .getAllProductController();
  }
}
