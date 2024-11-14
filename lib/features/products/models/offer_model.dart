class Offer {
  final bool isBuyGetOffer;
  final double? offerPrice;
  final int? buyQuantity;
  final int? getQuantity;
  final bool isSpecialOffer;

  Offer({
    required this.isBuyGetOffer,
    this.offerPrice,
    this.buyQuantity,
    this.getQuantity,
    required this.isSpecialOffer,
  });

  Map<String, dynamic> toMap() {
    return {
      "isBuyGetOffer": isBuyGetOffer,
      "offerPrice": offerPrice,
      "buyQuantity": buyQuantity,
      "getQuantity": getQuantity,
      "isSpecialOffer": isSpecialOffer,
    };
  }

  static Offer fromMap(Map<String, dynamic> map) {
    return Offer(
      isBuyGetOffer: map["isBuyGetOffer"] ?? false,
      offerPrice: (map["offerPrice"] as num?)?.toDouble(),
      buyQuantity: map["buyQuantity"] ?? 0,
      getQuantity: map["getQuantity"] ?? 0,
      isSpecialOffer: map["isSpecialOffer"] ?? false,
    );
  }
}
