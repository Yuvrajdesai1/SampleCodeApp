import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:nftapp/model/product_model.dart';
import 'package:nftapp/model/purchase_history_model.dart';

class ProductService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Product> userProduct = [];
  List<PurchasedHistory> transactions = [];
  List<Product> allProduct = [];
  Product? product = Product();
  String? imageUrl;

  // ------------- add new product -----------
  Future addProduct(Product product) async {
    await _firebaseFirestore.collection("products").add(product.toJson());
  }

  // -------------- add product image ----------------
  Future addImage(image, imageName) async {
    Reference firebaseStorageRef =
        await FirebaseStorage.instance.ref().child(imageName);
    String imageUrl =
        await firebaseStorageRef.putFile(image).then((value) async {
      String result = await value.ref.getDownloadURL();
      return result;
    });

    return imageUrl;
  }

  // ------------- get user product ------------
  Future getUserProduct() async {
    var response = await _firebaseFirestore
        .collection("products")
        .where("buyerId", isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();
    response.docs.forEach((element) async {
      userProduct.add(Product.fromJson(element.data()));
    });
    return userProduct;
  }

  // ----------------- gte product transactions  -------------
  Future getProductTransaction(prodId) async {
    transactions.clear();
    var response = await _firebaseFirestore
        .collection("purchasedHistory")
        .where("prodId", isEqualTo: prodId)
        .orderBy("buyingTime", descending: true)
        .get();
    response.docs.forEach((element) async {
      transactions.add(PurchasedHistory.fromJson(element.data()));
    });
    return transactions;
  }

  // ------------------- get single product ----------------
  Future getSingleProduct(prodId) async {
    var response = await _firebaseFirestore
        .collection("products")
        .where("prodId", isEqualTo: prodId)
        .get();
    response.docs.forEach((element) async {
      product = Product.fromJson(element.data());
    });
    return product;
  }

  // ------------- set product rate -------------------
  Future setRate(prodId, rate) async {
    var response = await _firebaseFirestore
        .collection("products")
        .where("prodId", isEqualTo: prodId)
        .get();
    response.docs.forEach((element) async {
      product = Product.fromJson(element.data());
      product!.price = rate;
      _firebaseFirestore
          .collection("products")
          .doc(element.id)
          .set(product!.toJson());
    });
    return product;
  }

  // ---------------- change product ownership --------------
  Future changeProductOwner(prodId) async {
    var response = await _firebaseFirestore
        .collection("products")
        .where("prodId", isEqualTo: prodId)
        .get();
    response.docs.forEach((element) async {
      product = Product.fromJson(element.data());
      product!.buyerId = FirebaseAuth.instance.currentUser!.uid;
      product!.lastBuyingTime = DateTime.now().toString();
      product!.price = null;
      _firebaseFirestore
          .collection("products")
          .doc(element.id)
          .set(product!.toJson());
    });
  }

  // -------------------- get all products --------------
  Future getAllProduct() async {
    var response = await _firebaseFirestore.collection("products").get();
    response.docs.forEach((element) async {
      allProduct.add(Product.fromJson(element.data()));
    });
    return allProduct;
  }

  // ---------------add new product transaction ------------
  addOwnerTransaction(buyerName, prodId, price, buyOrSell, buyerImage) async {
    PurchasedHistory purchasedHistory = PurchasedHistory(
      buyOrSell: buyOrSell,
      buyerName: buyerName,
      prodId: prodId,
      buyingPrice: price,
      buyingTime: DateTime.now().toString(),
      buyerImage: buyerImage,
    );
    await _firebaseFirestore
        .collection("purchasedHistory")
        .add(purchasedHistory.toJson());
  }
}
