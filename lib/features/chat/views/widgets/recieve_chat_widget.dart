import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class RecieveChatWidget extends StatelessWidget {
  final String msg;

  const RecieveChatWidget({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align to the left side
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(
            maxWidth: size.scaledWidth(80),
            minHeight: size.scaledHeight(7),
          ),
          decoration: BoxDecoration(
            color: AppColors().recieveBgc,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "John Son",
                    style: TextStyle(
                        color: AppColors().appBlack,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "03:00 PM",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                msg,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}
