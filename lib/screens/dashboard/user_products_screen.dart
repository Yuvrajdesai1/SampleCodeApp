import 'package:flutter/material.dart';
import 'package:nftapp/screens/dashboard/product_detail_screen.dart';
import 'package:nftapp/widgets/prefix_icon.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';
import '../../utils/app_const.dart';
import '../../utils/theme_manager.dart';
import '../../widgets/cuatom_appbar.dart';
import '../user_screen/setting_screen.dart';

class UserProducts extends StatefulWidget {
  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  bool isLoading = true;

  @override
  void initState() {
    getUserProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLoading = Provider.of<ProductController>(context, listen: true).isLoading;

    return Scaffold(
      /// ------------ appbar ------------

      appBar: CustomAppBar(
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
          ),
          title: "Search",
          prefixIcon: PrifixIcon()),
      body: Consumer<ProductController>(
        builder: (context, value, child) {
          return isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: value.userProducts!.length,
                  itemBuilder: (context, index) {
                    // ------------- user products section --------------
                    return value.userProducts![index].price == null
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                          prodId: value
                                              .userProducts![index].prodId!,
                                          isLikeScreen: false),
                                    ));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(value.userProducts![index].title
                                        .toString()),
                                    Image.network(
                                        value.userProducts![index].imageName!),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  });
        },
      ),
    );
  }

  // --------------- get user products -------------
  getUserProduct() async {
    await Provider.of<ProductController>(context, listen: false)
        .getUserProductController();
  }
}
