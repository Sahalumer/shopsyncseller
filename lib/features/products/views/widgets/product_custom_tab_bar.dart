import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class ProductCustomTabBar extends StatelessWidget {
  const ProductCustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black54,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      indicator: BoxDecoration(
        color: AppColors().appBackgroundColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(text: "Products 📦"),
        Tab(text: "Offer Zone 😱"),
      ],
    );
  }
}
