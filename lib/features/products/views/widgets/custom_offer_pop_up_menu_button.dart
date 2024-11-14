import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/views/screens/offer_add_edit_view.dart';
import 'package:shopsyncseller/features/products/views/screens/product_add_edit_view.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_delete_msg.dart';
import 'package:shopsyncseller/features/products/views/widgets/remove_offer_dialog.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_detailed_view.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_main_view.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class CustomOfferPopUpMenuButton extends StatelessWidget {
  final OfferProductModel productModel;

  const CustomOfferPopUpMenuButton({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    bool isDialogOpen = false;

    return BlocListener<SupplierBloc, SupplierState>(
      listener: (context, state) {
        if (state is SupplierLoading && !isDialogOpen) {
          isDialogOpen = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(child: CircularProgressIndicator()),
          );
        } else if (isDialogOpen) {
          Navigator.of(context, rootNavigator: true).pop();
          isDialogOpen = false;
          if (state is SupplierFound) {
            _showSupplierFoundDialog(context, state.supplier);
          } else if (state is SupplierNotFound) {
            _showSupplierNotFoundDialog(context);
          } else if (state is SupplierError) {
            _showErrorDialog(context, state.msg);
          }
        }
      },
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          switch (value) {
            case 'Edit Product':
              CustomNavigator.goTo(
                context,
                ProductAddEditView(offerProduct: productModel),
              );
              break;
            case 'Delete':
              offerProductDeletemsd(context, productModel.id!);
              break;
            case 'Supplier':
              context
                  .read<SupplierBloc>()
                  .add(SearchSupplierByProductId(productModel.id!));
              break;
            case 'Remove from Offer Zone':
              removeFromOffer(context, productModel.id!);
              break;
            case "Edit Offer":
              CustomNavigator.goTo(
                context,
                OfferDialog(productId: productModel.id),
              );
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Edit Product',
            child: Text('Edit Product'),
          ),
          const PopupMenuItem(
            value: "Edit Offer",
            child: Text("Edit Offer"),
          ),
          const PopupMenuItem(
            value: 'Delete',
            child: Text('Delete'),
          ),
          const PopupMenuItem(
            value: 'Supplier',
            child: Text('Supplier'),
          ),
          const PopupMenuItem(
            value: 'Remove from Offer Zone',
            child: Text('Remove from Offer Zone'),
          ),
        ],
      ),
    );
  }

  void _showSupplierFoundDialog(BuildContext context, SupplierModel supplier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Supplier Found"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${supplier.name}"),
              Text("Contact: ${supplier.contact}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Back"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                CustomNavigator.goTo(
                  context,
                  SupplierDetailedView(supplierId: supplier.id!),
                );
              },
              child: Text("See Details"),
            ),
          ],
        );
      },
    );
  }

  void _showSupplierNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Supplier Not Found"),
          content: Text("No supplier is added for this product."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Back"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                CustomNavigator.goTo(
                  context,
                  SupplierMainView(
                    productId: productModel.id,
                  ),
                );
              },
              child: Text("Add Supplier"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMsg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
