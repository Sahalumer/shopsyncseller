import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/supplier/views/widgets/supplier_text_field.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class AddSupplierFormComponents extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController contactController;
  final TextEditingController cityController;
  final TextEditingController districtController;
  final TextEditingController stateController;
  final TextEditingController pincodeController;

  const AddSupplierFormComponents(
      {super.key,
      required this.nameController,
      required this.contactController,
      required this.cityController,
      required this.districtController,
      required this.stateController,
      required this.pincodeController});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      children: [
        SupplierTextField(
          hintText: "Enter the shop or owner name",
          labelText: "Name",
          keyboardType: TextInputType.text,
          prefixIcon: const Icon(Icons.store),
          controller: nameController,
        ),
        SizedBox(height: size.scaledHeight(1)),
        SupplierTextField(
          hintText: "Enter contact number",
          labelText: "Contact",
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone),
          controller: contactController,
        ),
        SizedBox(height: size.scaledHeight(1)),
        Row(
          children: [
            Expanded(
              child: SupplierTextField(
                hintText: "Enter city name",
                labelText: "City",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.location_city),
                controller: cityController,
              ),
            ),
            SizedBox(width: size.scaledWidth(2)),
            Expanded(
              child: SupplierTextField(
                hintText: "Enter district name",
                labelText: "District",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.map),
                controller: districtController,
              ),
            ),
          ],
        ),
        SizedBox(height: size.scaledHeight(1)),
        Row(
          children: [
            Expanded(
              child: SupplierTextField(
                hintText: "Enter state name",
                labelText: "State",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.public),
                controller: stateController,
              ),
            ),
            SizedBox(width: size.scaledWidth(2)),
            Expanded(
              child: SupplierTextField(
                hintText: "Enter pincode",
                labelText: "Pincode",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.pin),
                controller: pincodeController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
