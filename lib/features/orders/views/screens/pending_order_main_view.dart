import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/orders/views/screens/pending_detailed_view.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class PendingOrderMainView extends StatelessWidget {
  const PendingOrderMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0, left: 5, right: 5),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => InkWell(
          onTap: () => CustomNavigator.goTo(context, PendingDetailedView()),
          child: Card(
            color: AppColors().appWhite,
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: size.scaledHeight(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("John son",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Item : 3",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Payment pending",
                    style: TextStyle(color: AppColors().appWarning),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
