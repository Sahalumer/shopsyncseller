import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class SendChatWidget extends StatelessWidget {
  const SendChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: size.scaledWidth(80),
        minHeight: size.scaledHeight(7),
      ),
      decoration: BoxDecoration(
        color: AppColors().sendBgc,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text left
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "You",
                style: TextStyle(
                    color: AppColors().appBlack, fontWeight: FontWeight.w400),
              ),
              Text(
                "05:00 PM",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "Please do the payment and confirm the order",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
