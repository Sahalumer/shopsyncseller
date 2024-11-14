import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/features/supplier/views/componenets/supplier_details_components.dart';
import 'package:shopsyncseller/features/supplier/views/componenets/supplier_products_components.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class SupplierDetailedView extends StatelessWidget {
  final String supplierId;
  const SupplierDetailedView({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context) {
    context.read<SupplierBloc>().add(FetchSingleSuppliersById(supplierId));
    void _deleteSupplier() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Supplier'),
          content: const Text('Are you sure you want to delete this supplier?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<SupplierBloc>().add(DeleteSupplier(supplierId));
                CustomNavigator.goBack(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Supplier Deleted Successfully!')),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Supplier",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _deleteSupplier();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: BlocBuilder<SupplierBloc, SupplierState>(
        builder: (context, state) {
          if (state is SupplierLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SingleSupplierLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SupplierDetailsComponents(supplier: state.supplier),
                  SizedBox(
                    height: 15,
                  ),
                  SupplierProductsComponents(supplier: state.supplier)
                ],
              ),
            );
          }
          return Center(
            child: Text("Unexpected state $state"),
          );
        },
      ),
    );
  }
}
