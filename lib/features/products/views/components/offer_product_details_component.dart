import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class OfferProductDetailsComponent extends StatelessWidget {
  final OfferProductModel productModel;

  const OfferProductDetailsComponent({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    final hasSpecialOffer = productModel.offer?.isSpecialOffer ?? false;
    final hasBuyGetOffer = productModel.offer?.isBuyGetOffer ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 8),
        _buildPriceRow(hasSpecialOffer, size),
        if (hasBuyGetOffer) _buildBuyGetOfferText(),
        const SizedBox(height: 8),
        _buildQuantityInfo(),
        const SizedBox(height: 10),
        _buildReviewStars(productModel.reviewGraph),
        const SizedBox(height: 10),
        _buildAboutSection(size),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      productModel.productName,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _buildPriceRow(bool hasSpecialOffer, CustomMediaQuery size) {
    final offerPrice = productModel.offer?.offerPrice?.toInt().toString() ?? '';
    final regularPrice = productModel.price.toInt().toString();

    return Row(
      children: [
        Text(
          hasSpecialOffer ? offerPrice : regularPrice,
          style: TextStyle(
            color: hasSpecialOffer ? Colors.green : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        if (hasSpecialOffer) ...[
          SizedBox(width: size.scaledWidth(1)),
          Text(
            regularPrice,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        ],
        SizedBox(width: size.scaledWidth(1)),
        Text(
          " per ${productModel.unit}",
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBuyGetOfferText() {
    return Text(
      "Buy ${productModel.offer!.buyQuantity} get ${productModel.offer!.getQuantity} Free",
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildQuantityInfo() {
    return Text(
      "QTY: ${productModel.quantity}",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
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
        return Icon(
          index < filledStars ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }

  Widget _buildAboutSection(CustomMediaQuery size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.scaledHeight(1)),
        Text(
          productModel.description,
          style: const TextStyle(fontSize: 15),
        ),
        SizedBox(height: size.scaledHeight(2)),
      ],
    );
  }
}
