import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/profile/models/store_details_model.dart';
import 'package:shopsyncseller/features/profile/views/components/show_details_mini_component.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class SectionView extends StatefulWidget {
  final String title;
  final StoreDetailsModel? storeDetailsModel;
  final String uid;
  const SectionView(
      {super.key,
      required this.title,
      this.storeDetailsModel,
      required this.uid});

  @override
  State<SectionView> createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              open = !open;
            });
          },
          child: Container(
            height: size.scaledHeight(8),
            width: size.screenWidth,
            decoration: BoxDecoration(
              color: AppColors().appWhite,
              borderRadius: open
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
              boxShadow: open
                  ? [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      open ? Icons.expand_less : Icons.expand_more,
                      color: AppColors().appBlack,
                      size: 36,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if (open)
          widget.title == "Orders"
              ? Container(
                  padding: const EdgeInsets.all(16),
                  width: size.screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text("No Orders yet"),
                  ),
                )
              : ShowDetailsMiniComponent(
                  uid: widget.uid,
                )
      ],
    );
  }
}
