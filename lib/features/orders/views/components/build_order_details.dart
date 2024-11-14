import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class BuildOrderDetails extends StatelessWidget {
  const BuildOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "John son",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Item : 3",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Track Id : 3851181313861",
                style: TextStyle(color: AppColors().appWarning),
              ),
              const Text("01/01/2025"),
            ],
          ),
        ],
      ),
    );
  }
}
