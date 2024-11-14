import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class TypeingBarWidget extends StatelessWidget {
  const TypeingBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().appGrey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Emoji or extra features icon
            IconButton(
              icon: const Icon(Icons.emoji_emotions),
              onPressed: () {},
            ),
            // Message Text Field
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Message...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
                minLines: 1, // Minimum lines (like WhatsApp)
                maxLines: null, // No limit on maximum lines
                keyboardType: TextInputType.multiline, // M
              ),
            ),
            // Voice Message and Attachment Icons
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.attachment),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
