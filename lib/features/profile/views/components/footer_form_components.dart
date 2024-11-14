import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class FooterFormComponents extends StatelessWidget {
  final String buttonText;
  final VoidCallback onSubmit;

  const FooterFormComponents({
    super.key,
    required this.buttonText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      children: [
        SizedBox(height: size.scaledHeight(5)),
        InkWell(
          onTap: onSubmit,
          child: Container(
            width: size.scaledWidth(70),
            height: size.scaledHeight(7),
            decoration: BoxDecoration(
              color: AppColors().appBlack,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: AppColors().appWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
