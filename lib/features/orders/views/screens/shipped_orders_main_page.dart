import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/orders/views/components/build_order_details.dart';
import 'package:shopsyncseller/features/orders/views/components/build_reciept_section.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ShippedOrdersMainPage extends StatelessWidget {
  const ShippedOrdersMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Card(
            color: AppColors().appWhite,
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: size.scaledHeight(10),
              child: const Row(
                children: [
                  BuildRecieptSection(),
                  SizedBox(width: 6),
                  BuildOrderDetails(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
