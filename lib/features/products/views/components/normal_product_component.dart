import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/views/screens/product_detailed_view.dart';
import 'package:shopsyncseller/features/products/views/widgets/custom_pop_up_menu_button.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class NormalProductComponent extends StatelessWidget {
  final ProductModel productModel;
  final int gridIndex;
  const NormalProductComponent({
    super.key,
    required this.productModel,
    required this.gridIndex,
  });

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return InkWell(
      onTap: () {
        CustomNavigator.goTo(
            context,
            ProductDetailedView(
              productid: productModel.id!,
              gridIndex: gridIndex,
            ));
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
                      image: FileImage(File(productModel.pictures[0])),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.scaledHeight(2)),
              Text(
                productModel.productName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 0.1,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹ ${productModel.price}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomProductPopUpMenuButton(productModel: productModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
