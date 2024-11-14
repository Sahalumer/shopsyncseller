import 'package:shopsyncseller/features/products/models/review_model.dart';

class ProductModel {
  final String productName;
  final double price;
  final String description;
  final List<String> pictures;
  final List<ReviewModel> reviews;
  final String unit;
  final int quantity;
  final Map<int, int> reviewGraph;
  String? id;

  ProductModel({
    this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.pictures,
    required this.reviews,
    required this.unit,
    required this.reviewGraph,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "productName": productName,
      "price": price,
      "description": description,
      "pictures": pictures,
      "reviews": reviews.map((review) => review.toMap()).toList(),
      "unit": unit,
      "quantity": quantity,
      "reviewGraph": reviewGraph,
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"] ?? "",
      productName: map["productName"] ?? '',
      price: (map["price"] as num?)?.toDouble() ?? 0.0,
      description: map["description"] ?? '',
      pictures: List<String>.from(map["pictures"] ?? []),
      reviews: (map["reviews"] as List?)
              ?.map((reviewMap) => ReviewModel.fromMap(reviewMap))
              .toList() ??
          [],
      reviewGraph: Map<int, int>.from(map["reviewGraph"] ?? {}),
      unit: map["unit"] ?? '',
      quantity: (map["quantity"] as num?)?.toInt() ?? 0,
    );
  }
}
