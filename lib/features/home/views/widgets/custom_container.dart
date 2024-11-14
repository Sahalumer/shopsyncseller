import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class CustomGrid extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomGrid({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = CustomMediaQuery(context);
    return Container(
      height: mediaQuery.scaledHeight(16),
      width: mediaQuery.scaledWidth(46),
      decoration: BoxDecoration(
        color: AppColors().appWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
