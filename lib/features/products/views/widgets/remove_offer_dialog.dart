import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

removeFromOffer(BuildContext context, String productId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm remove"),
      content: const Text(
        "Are you sure you want to remove this product from Offer Zone? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () async {
            context.read<OfferProductBloc>().add(RemoveOffer(productId));
            CustomNavigator.goBack(context);
          },
          child: Text(
            "Yes, Remove",
            style: TextStyle(
              color: AppColors().appWarning,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No, Keep it"),
        ),
      ],
    ),
  );
}
