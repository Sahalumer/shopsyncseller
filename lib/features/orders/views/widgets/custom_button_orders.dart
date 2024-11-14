import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class CustomButtonOrders extends StatelessWidget {
  final String text;
  final VoidCallback button;
  const CustomButtonOrders(
      {super.key, required this.text, required this.button});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return InkWell(
      onTap: button,
      child: Container(
        width: size.scaledWidth(43),
        height: size.scaledHeight(6),
        decoration: BoxDecoration(
          color: AppColors().appBlack,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors().appWhite,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
