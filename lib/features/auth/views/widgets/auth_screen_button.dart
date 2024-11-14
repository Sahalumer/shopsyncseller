import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class AuthScreensButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  const AuthScreensButton(
      {super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: MediaQuery.of(context).size.height * .06,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: AppColors().appBlack,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors().appWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
