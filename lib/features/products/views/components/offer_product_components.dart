import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/views/screens/offer_product_detailed_view.dart';
import 'package:shopsyncseller/features/products/views/widgets/custom_offer_pop_up_menu_button.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class OfferProductComponents extends StatelessWidget {
  final OfferProductModel product;
  final int gridIndex;

  const OfferProductComponents({
    super.key,
    required this.product,
    required this.gridIndex,
  });

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    final hasSpecialOffer = product.offer?.isSpecialOffer ?? false;
    final hasBuyGetOffer = product.offer?.isBuyGetOffer ?? false;

    return InkWell(
      onTap: () {
        CustomNavigator.goTo(
            context, OfferProductDetailedView(productId: product.id!));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().appWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: size.scaledPadding(1, .5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(product.pictures[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.scaledHeight(2)),
              Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 0.1,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              if (hasSpecialOffer)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "₹ ${product.offer!.offerPrice!.toInt()}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 7, 109, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "₹ ${(product.price).toInt()}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    CustomOfferPopUpMenuButton(productModel: product),
                  ],
                ),
              if (!hasSpecialOffer)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${product.price.toInt()}",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors().appBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomOfferPopUpMenuButton(productModel: product),
                  ],
                ),
              if (hasBuyGetOffer)
                Text(
                  "Buy 1 Get 2 Free",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    height: 0.1,
                  ),
                ),
              SizedBox(
                height: size.scaledHeight(1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
