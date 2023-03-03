import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/widgets/custom_button.dart';
import 'package:nftapp/widgets/custom_textField.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../controllers/product_controller.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/cuatom_appbar.dart';
import '../../widgets/prefix_icon.dart';

class ProductDetailScreen extends StatefulWidget {
  bool isLikeScreen;
  String prodId;

  ProductDetailScreen({required this.isLikeScreen, required this.prodId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ThemeManager _themeManager = ThemeManager();

  TextEditingController _rateController = TextEditingController();

  String? name;
  String? buyerImage;

  bool isLoading = true;
  bool isToSell = false;

  @override
  void initState() {
    getProductDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    isLoading = Provider.of<ProductController>(context, listen: true).isLoading;

    return Scaffold(
      backgroundColor: _themeManager.getWhiteColor,

      /// ------------ appbar -------------
      appBar: CustomAppBar(
          title: "Sale", prefixIcon: PrifixIcon(), actions: Container()),

      body: Consumer<ProductController>(
        builder: (context, value, child) {
          if (isLoading == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: height * 0.02,
                    bottom: height * 0.01,
                    left: width * 0.04,
                    right: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------- product image section -----------
                    Container(
                        height: height * 0.25,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.025),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(width * 0.025),
                          child: Image.network(
                            value.product.imageName!,
                            fit: BoxFit.fill,
                          ),
                        )),
                    // ------------- product title section -----------
                    Container(
                      margin: EdgeInsets.only(top: height * 0.015),
                      child: Text(
                        value.product.title!,
                        style: FontUtils.promptSemiBoldStyle
                            .copyWith(fontSize: width * 0.045),
                      ),
                    ),
                    // ------------- product description section -----------

                    Container(
                      margin: EdgeInsets.only(top: height * 0.008),
                      child: Text(
                        value.product.description!,
                        style: FontUtils.promptRegularStyle
                            .copyWith(fontSize: width * 0.035),
                      ),
                    ),

                    value.product.price == null &&
                            widget.isLikeScreen == false &&
                            FirebaseAuth.instance.currentUser!.uid ==
                                value.product.buyerId
                        ? isToSell
                            // ------------- product price set section -----------

                            ? Container(
                                height: height * 0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: height * 0.055,
                                          bottom: height * 0.005),
                                      child: Text(
                                        "Selling Price",
                                        style: FontUtils.promptRegularStyle
                                            .copyWith(
                                                fontSize: width * 0.035,
                                                color: _themeManager
                                                    .getGreyFontColor),
                                      ),
                                    ),
                                    CustomTextField(
                                      validator: () {},
                                      hintText: "Price",
                                      isActive: true,
                                      numberOfLine: 1,
                                      keyboardType: TextInputType.number,
                                      obSecure: false,
                                      controller: _rateController,
                                      obscureText: false,
                                    ),
                                  ],
                                ))
                            : Container(
                                height: height * 0.35,
                              )
                        : Container(),
                    (value.product.price == null &&
                            FirebaseAuth.instance.currentUser!.uid ==
                                value.product.buyerId &&
                            widget.isLikeScreen == false)

                        // ------------- product sell button -----------

                        ? GestureDetector(
                            onTap: () async {
                              if (isToSell == true) {
                                await Provider.of<ProductController>(context,
                                        listen: false)
                                    .setRateController(widget.prodId,
                                        _rateController.text, name, buyerImage);
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  isToSell = true;
                                });
                              }
                            },
                            child: CustomButton(
                                title: isToSell ? "To Sell" : "Sell"),
                          )
                        : Column(
                            children: [
                              Container(
                                height: height * 0.25,
                                child: ListView.builder(
                                  itemCount: value.transactions.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                    child: Column(children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: height * 0.04),
                                        child: TimelineTile(
                                          indicatorStyle: IndicatorStyle(
                                            color:
                                                _themeManager.getPinkFontColor,
                                            width: width * 0.03,
                                          ),
                                          beforeLineStyle: LineStyle(
                                            color:
                                                _themeManager.getPinkFontColor,
                                          ),
                                          alignment: TimelineAlign.start,
                                          isFirst: true,
                                          endChild: Container(
                                            margin: EdgeInsets.only(
                                                left: width * 0.02,
                                                right: width * 0.04),
                                            height: height * 0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.025),
                                              color: _themeManager
                                                  .getGreyBackgroundColor,
                                            ),
                                            child: Row(children: [
                                              value.transactions[index]
                                                          .buyerImage ==
                                                      ""
                                                  ? Icon(Icons
                                                      .supervised_user_circle_outlined)
                                                  : Image.network(value
                                                      .transactions[index]
                                                      .buyerImage),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        DateFormat.yMMMMd()
                                            .format(DateTime.parse(value
                                                .transactions[index]
                                                .buyingTime))
                                            .toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(value.transactions[index].buyerName),
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // ------- get product details ---------
  getProductDetail() async {
    Provider.of<ProductController>(context, listen: false)
        .getSingleProductController(widget.prodId);
    Provider.of<ProductController>(context, listen: false)
        .productTransactionController(widget.prodId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString(Session().firstName);
    buyerImage = await prefs.getString(Session().buyerImage);
  }
}
