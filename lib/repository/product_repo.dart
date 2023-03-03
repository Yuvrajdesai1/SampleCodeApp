import 'dart:io';

import 'package:flutter/material.dart';

import '../model/product_model.dart';

abstract class ProductRepo {
  //------------------- add new product ----------------
  void addProductController(Product product);

  //------------------- add new product ----------------
  void addImageController(File image, BuildContext context, Product product);

  //------------------- get all products ------------------
  void searchProductController(String searchWord);

  //------------------- get userProducts -----------------
  Future getUserProductController();

  //------------------- get stopSearching -----------------
  void stopSearchingController();

  //------------------- get getAllProduct -----------------
  Future getAllProductController();

  //------------------- get getSingleProduct -----------------
  Future getSingleProductController(prodId);

  //------------------- Set Rate -----------------
  Future setRateController(prodId, rate, name,buyerImage);

  //------------------- Change Product Ownership -----------------
  Future changeProductOwnerShipController(prodId);

  // ------------------ get product transaction --------------
  Future productTransactionController(prodId);

  // ------------------ add owner product transaction --------------
  Future addOwnerTransactionController(prodId, buyerName,price,buyOrSell,buyerImage);


}
