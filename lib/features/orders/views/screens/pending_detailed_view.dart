import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/chat/views/screens/detailed_chat_page.dart';
import 'package:shopsyncseller/features/orders/views/components/customer_information_card.dart';
import 'package:shopsyncseller/features/orders/views/components/items_incart.dart';
import 'package:shopsyncseller/features/orders/views/widgets/custom_button_orders.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class PendingDetailedView extends StatelessWidget {
  const PendingDetailedView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Order Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerInformationCard(),
                    const Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.scaledHeight(32),
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) => ItemsIncart(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Qty : 6",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Delivery Charge : 50",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Total : 12044",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonOrders(
                      text: "Back",
                      button: () => CustomNavigator.goBack(context),
                    ),
                    CustomButtonOrders(
                      text: "Chat",
                      button: () =>
                          CustomNavigator.goTo(context, DetailedChatPage()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
