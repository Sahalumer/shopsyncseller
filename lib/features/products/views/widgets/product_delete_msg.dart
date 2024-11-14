import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

offerProductDeletemsd(BuildContext context, String productId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text(
        "Are you sure you want to delete this product? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () async {
            print(productId);
            context.read<OfferProductBloc>().add(DeleteOfferProduct(productId));
            CustomNavigator.goBack(context);
          },
          child: Text(
            "Yes, Delete",
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

productDeletemsd(BuildContext context, String productId) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Deletion"),
      content: const Text(
        "Are you sure you want to delete this product? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<ProductBloc>().add(DeleteProduct(productId));
            CustomNavigator.goBack(context);
          },
          child: Text(
            "Yes, Delete",
            style: TextStyle(
              color: AppColors().appWarning,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: const Text("No, Keep it"),
        ),
      ],
    ),
  );
}
