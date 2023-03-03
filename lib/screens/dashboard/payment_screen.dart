import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/product_controller.dart';
import '../../utils/app_const.dart';

class PaymentPage extends StatefulWidget {
  String prodId;

  PaymentPage({required this.prodId});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = true;
  TextEditingController _cardNumberController = TextEditingController();

  String name = "";
  String buyerImage = "";

  @override
  void initState() {
    getProductDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ------------ appbar -----------
      appBar: AppBar(title: Text("payment")),
      body: Consumer<ProductController>(
        builder: (context, value, child) {
          if (isLoading == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // -------------- product image section -----------
                  Image.network(value.product.imageName!),
                  // -------------- product title section -----------
                  Text(value.product.title!),
                  // -------------- product price section -----------

                  Text(value.product.price!),

                  // -------------- card number section -----------

                  TextFormField(controller: _cardNumberController),

                  // -------------- buy button -----------

                  GestureDetector(
                    onTap: () async {
                      await value.changeProductOwnerShipController(
                        value.product.prodId,
                      );
                      await value.addOwnerTransactionController(
                          value.product.prodId,
                          name,
                          value.product.price,
                          "buy",
                          buyerImage);
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Text("submit"),
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // ------------- get product details from server --------
  getProductDetail() async {
    Provider.of<ProductController>(context, listen: false)
        .getSingleProductController(widget.prodId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString(Session().firstName)!;
    buyerImage = await prefs.getString(Session().buyerImage)!;
    setState(() {
      isLoading = false;
    });
  }
}
