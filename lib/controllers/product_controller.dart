import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:nftapp/model/product_model.dart';
import 'package:nftapp/repository/product_repo.dart';
import 'package:path/path.dart';
import 'package:nftapp/services/product_service.dart';

import '../model/purchase_history_model.dart';

class ProductController extends ProductRepo with ChangeNotifier {
  ProductService _productService = ProductService();
  Product product = Product();
  List<Product>? userProducts = [];
  List<Product>? allProducts = [];
  List<PurchasedHistory> transactions = [];
  List<Product>? searchProduct = [];
  bool isLoading = true;
  bool isSearching = false;

  String imageUrl = "";

  // ---------- add product controller ------------
  @override
  Future addProductController(Product product) async {
    await _productService.addProduct(product);
    getUserProductController();
    getAllProductController();
  }

  // ---------- search product controller -----------
  @override
  searchProductController(String searchWord) {
    isSearching = true;
    notifyListeners();
    searchProduct!.clear();
    for (var i = 0; i < allProducts!.length; i++) {
      if (allProducts![i].title!.contains(searchWord)) {
        searchProduct!.add(allProducts![i]);
        notifyListeners();
      }
    }
  }

  // ---------- stop searching controller -------------
  @override
  stopSearchingController() {
    isSearching = false;
    notifyListeners();
  }

  // ---------- get user product controller ------------
  @override
  getUserProductController() async {
    isLoading = true;
    userProducts!.clear();
    userProducts = await _productService.getUserProduct();
    notifyListeners();
    isLoading = false;
  }

  // ------------ get all product controller ------------
  @override
  getAllProductController() async {
    isLoading = true;
    allProducts!.clear();
    allProducts = await _productService.getAllProduct();
    notifyListeners();
    log(allProducts!.length.toString());
    isLoading = false;
  }

  // ----------- add image controller ------------
  @override
  Future addImageController(
      File image, BuildContext context, Product product) async {
    isLoading = true;
    String fileName = basename(image.path);
    await _productService.addImage(image, "$fileName").then((value) async {
      product.imageName = await value;
      addProductController(product).whenComplete(() {
        isLoading = false;
      });
    });
  }

  // ------------ get single product controller  ----------------
  @override
  getSingleProductController(prodId) async {
    isLoading = true;
    product = await _productService.getSingleProduct(prodId);
    notifyListeners();
    isLoading = false;
  }

  // ------------ set rate controller -----------
  @override
  setRateController(prodId, rate, name, buyerImage) async {
    isLoading = true;
    product = await _productService.setRate(prodId, rate);
    notifyListeners();

    addOwnerTransactionController(prodId, name, rate, "sell", buyerImage);

    isLoading = false;
  }

  // ------------ change product ownership controller -----------
  @override
  changeProductOwnerShipController(prodId) async {
    isLoading = true;
    await _productService.changeProductOwner(prodId);
    getAllProductController();
  }

  // ------------ product transaction controller --------------
  @override
  Future productTransactionController(prodId) async {
    transactions = await _productService.getProductTransaction(prodId);
    notifyListeners();
    return transactions;
  }

  // ----------- add owner transaction controller ------------
  @override
  Future addOwnerTransactionController(
      prodId, buyerName, price, buyOrSell, buyerImage) async {
    await _productService.addOwnerTransaction(
        buyerName, prodId, price, buyOrSell, buyerImage);
  }
}
