import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';

class SupplierDetailsComponents extends StatelessWidget {
  final SupplierModel supplier;

  const SupplierDetailsComponents({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Supplier Details",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 16),
          buildDetailRow("Name:", supplier.name),
          buildDetailRow("Contact:", supplier.contact),
          buildDetailRow("City:", supplier.city),
          buildDetailRow("District:", supplier.district),
          buildDetailRow("State:", supplier.state),
          buildDetailRow("Pincode:", supplier.pincode.toString()),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Vertical padding for spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
