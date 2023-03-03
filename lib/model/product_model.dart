import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? prodId;
  String? title;
  String? description;
  String? imageName;
  String? price;
  String? type;
  String? buyerId;
  String? ownerUserId;
  Timestamp? createdTime;
  String? lastBuyingTime;

  Product({
    this.title,
    this.buyerId,
    this.description,
    this.type,
    this.imageName,
    this.price,
    this.createdTime,
    this.ownerUserId,
    this.prodId,
    this.lastBuyingTime,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json["title"] as String,
      prodId: json["prodId"] as String,
      buyerId: json["buyerId"] as String,
      description: json["description"] as String,
      type: json["type"] as String,
      imageName: json["imageName"] as String,
      ownerUserId: json["ownerUserId"] as String,
      price: json["price"],
      createdTime: json["createdTime"],
      lastBuyingTime: json["lastBuyingTime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "prodId": prodId,
        "buyerId": buyerId,
        "description": description,
        "type": type,
        "imageName": imageName,
        "price": price,
        "ownerUserId": ownerUserId,
        "createdTime": createdTime,
        "lastBuyingTime": lastBuyingTime,
      };
}
