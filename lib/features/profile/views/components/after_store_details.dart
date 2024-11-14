import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/profile/models/store_details_model.dart';
import 'package:shopsyncseller/features/profile/views/components/section_view.dart';

class AfterStoreDetails extends StatelessWidget {
  final StoreDetailsModel storeDetails;
  final String uid;
  const AfterStoreDetails(
      {super.key, required this.storeDetails, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionView(
          title: "Store Details",
          storeDetailsModel: storeDetails,
          uid: uid,
        ),
        SizedBox(
          height: 10,
        ),
        SectionView(
          title: "Orders",
          uid: uid,
        )
      ],
    );
  }
}
