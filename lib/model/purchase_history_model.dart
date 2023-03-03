class PurchasedHistory {
  String prodId;
  String buyerName;
  String buyingPrice;
  String buyingTime;
  String buyOrSell;
  String buyerImage;

  PurchasedHistory(
      {required this.buyerName,
      required this.prodId,
      required this.buyingPrice,
      required this.buyingTime,
      required this.buyOrSell,
      required this.buyerImage});

  factory PurchasedHistory.fromJson(Map<String, dynamic> json) {
    return PurchasedHistory(
      buyerName: json["buyerName"],
      buyingPrice: json["buyingPrice"],
      buyingTime: json["buyingTime"],
      prodId: json["prodId"],
      buyOrSell: json["buyOrSell"],
      buyerImage: json["buyerImage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "buyerName": buyerName,
        "buyingPrice": buyingPrice,
        "buyingTime": buyingTime,
        "prodId": prodId,
        "buyOrSell": buyOrSell,
        "buyerImage": buyerImage,
      };
}
