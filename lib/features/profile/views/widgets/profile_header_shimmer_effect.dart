import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileHeaderShimmerEffect extends StatelessWidget {
  const ProfileHeaderShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
          ),
          SizedBox(height: 10),
          Container(
            width: 100.0,
            height: 20.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Container(
            width: 200.0,
            height: 20.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
