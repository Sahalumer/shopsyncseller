import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class BuildInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const BuildInfoRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors().appWhite),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: AppColors().appWhite,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
