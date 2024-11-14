import 'package:shopsyncseller/features/products/models/offer_model.dart';
import 'package:shopsyncseller/features/products/models/review_model.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';

class OfferProductModel {
  final String productName;
  final double price;
  final String description;
  final List<String> pictures;
  final Offer? offer;
  final List<ReviewModel> reviews;
  final String unit;
  final int quantity;
  final Map<int, int> reviewGraph;
  final SupplierModel? supplier;
  String? id;

  OfferProductModel({
    this.id,
    required this.productName,
    required this.price,
    required this.description,
    this.offer,
    required this.pictures,
    required this.reviews,
    required this.unit,
    required this.reviewGraph,
    this.supplier,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productName": productName,
      "price": price,
      "description": description,
      "pictures": pictures,
      "offer": offer?.toMap(),
      "reviews": reviews.map((review) => review.toMap()).toList(),
      "unit": unit,
      "quantity": quantity,
      "reviewGraph": reviewGraph,
      "supplier": supplier?.toMap(),
    };
  }

  static OfferProductModel fromMap(Map<String, dynamic> map) {
    return OfferProductModel(
      id: map["id"] ?? "",
      productName: map["productName"] ?? '',
      price: (map["price"] as num?)?.toDouble() ?? 0.0,
      description: map["description"] ?? '',
      pictures: List<String>.from(map["pictures"] ?? []),
      offer: map["offer"] != null ? Offer.fromMap(map["offer"]) : null,
      reviews: (map["reviews"] as List?)
              ?.map((reviewMap) => ReviewModel.fromMap(reviewMap))
              .toList() ??
          [],
      reviewGraph: Map<int, int>.from(map["reviewGraph"] ?? {}),
      unit: map["unit"] ?? '',
      quantity: (map["quantity"] as num?)?.toInt() ?? 0,
      supplier: map['supplier'] != null
          ? SupplierModel.fromMap(map['supplier'])
          : null,
    );
  }
}
