import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/products/models/review_model.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductReviews extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ProductReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    if (reviews.isEmpty) {
      return Text(
        "No reviews yet",
        style: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reviews",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: size.scaledHeight(1)),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Container(
              width: size.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors().appWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (starIndex) {
                          return Icon(
                            starIndex < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 15,
                          );
                        },
                      ),
                    ),
                    Text(
                      review.userId,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: size.scaledHeight(1)),
                    Text(review.comment),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
