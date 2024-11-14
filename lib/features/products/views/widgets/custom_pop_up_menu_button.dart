import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/views/screens/offer_add_edit_view.dart';
import 'package:shopsyncseller/features/products/views/screens/product_add_edit_view.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_delete_msg.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_detailed_view.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_main_view.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class CustomProductPopUpMenuButton extends StatelessWidget {
  final ProductModel productModel;

  const CustomProductPopUpMenuButton({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupplierBloc, SupplierState>(
      listener: (context, state) {
        if (state is SupplierFound) {
          _showSupplierFoundDialog(context, state.supplier);
        } else if (state is SupplierNotFound) {
          _showSupplierNotFoundDialog(context);
        } else if (state is SupplierError) {
          _showErrorDialog(context, state.msg);
        }
      },
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          switch (value) {
            case 'Edit':
              CustomNavigator.goTo(
                context,
                ProductAddEditView(product: productModel),
              );
              break;
            case 'Delete':
              productDeletemsd(context, productModel.id!);
              break;
            case 'Supplier':
              context
                  .read<SupplierBloc>()
                  .add(SearchSupplierByProductId(productModel.id!));
              break;
            case 'Move to Offer Zone':
              CustomNavigator.goTo(
                context,
                OfferDialog(productModel: productModel),
              );
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Edit',
            child: Text('Edit'),
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
            value: 'Move to Offer Zone',
            child: Text('Move to Offer Zone'),
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("Back"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                CustomNavigator.goTo(
                    context,
                    SupplierMainView(
                      productId: productModel.id,
                    ));
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
