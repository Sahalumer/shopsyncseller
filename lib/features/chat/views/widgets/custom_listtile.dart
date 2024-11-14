import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/chat/views/screens/detailed_chat_page.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class CustomListTile extends StatelessWidget {
  final int size; // Total number of list items
  const CustomListTile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: size,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          CustomNavigator.goTo(context, const DetailedChatPage());
        },
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          color: AppColors().appBackgroundColor, // Your custom background color
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Time Row
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "John Son", // You can pass dynamic data here
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "05:17 PM", // You can pass dynamic time
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "You : Please do the payment and confirm the order",
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        if (true)
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "2",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => Divider(
        color: AppColors().appWhite,
      ),
    );
  }
}
