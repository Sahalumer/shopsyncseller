import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductDetailedDetails extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailedDetails({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel.productName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Row(
          children: [
            Text(
              productModel.price.toInt().toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: size.scaledWidth(1),
            ),
            Text(" per ${productModel.unit}", style: TextStyle(fontSize: 12)),
          ],
        ),
        Text("QTY: ${productModel.quantity}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
        SizedBox(height: 10),
        _buildReviewStars(productModel.reviewGraph),
        SizedBox(
          height: size.scaledHeight(1),
        ),
        Text(
          "About",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: size.scaledHeight(1),
        ),
        Text(
          productModel.description,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: size.scaledHeight(2),
        )
      ],
    );
  }

  Widget _buildReviewStars(Map<int, int> reviewGraph) {
    int totalReviews = reviewGraph.values.fold(0, (sum, count) => sum + count);
    double totalRating = reviewGraph.entries.fold(0, (sum, entry) {
      return sum + (entry.key * entry.value);
    });

    double averageRating = totalReviews > 0 ? totalRating / totalReviews : 0.0;
    int filledStars = averageRating.round();

    return Row(
      children: List.generate(5, (index) {
        int rating = index + 1;
        return Icon(
          rating <= filledStars ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}
