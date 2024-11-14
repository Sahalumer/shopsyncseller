import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductDetailButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String text;
  const ProductDetailButton(
      {super.key, required this.onSubmit, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return InkWell(
      onTap: onSubmit,
      child: Container(
        height: size.scaledHeight(6),
        width: size.screenWidth,
        decoration: BoxDecoration(
          color: AppColors().appBlack,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors().appWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
