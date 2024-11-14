import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';

class SupplierProductsComponents extends StatelessWidget {
  final SupplierModel supplier;
  const SupplierProductsComponents({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
