import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class SplashComponents extends StatelessWidget {
  const SplashComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_bag,
          color: AppColors().appWhite,
          size: 150,
        ),
        Text(
          "Shop-Sync",
          style: TextStyle(
            color: AppColors().appWhite,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
