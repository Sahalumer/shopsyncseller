import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_text_filed.dart';
import 'package:shopsyncseller/features/products/views/widgets/unit_menu_drawer.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductFormFieldComponent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController unitController;
  final TextEditingController quantityController;

  const ProductFormFieldComponent({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.unitController,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return Column(
      children: [
        // Product Name Field
        ProductTextFiled(
          hintText: "Enter Product Name",
          labelText: "Product Name",
          keyboardType: TextInputType.name,
          prefixIcon:
              const Icon(Icons.inventory_2), // Icon suitable for products
          controller: nameController,
        ),
        SizedBox(height: size.scaledHeight(1)),

        // Row for Product Price and Unit Selector
        Row(
          children: [
            Expanded(
              child: ProductTextFiled(
                hintText: "Enter Product Price",
                labelText: "Price",
                keyboardType: TextInputType.number,
                prefixIcon:
                    const Icon(Icons.attach_money), // Money icon for price
                controller: priceController, // Corrected to use priceController
              ),
            ),
            SizedBox(width: size.scaledWidth(1)),
            Expanded(
              child: UnitMenuDrawer(
                units: const ['Pieces', 'Meters'],
                unitController: unitController,
              ),
            ),
          ],
        ),
        SizedBox(height: size.scaledHeight(1)),

        // Quantity Field
        ProductTextFiled(
          hintText: "Enter Quantity",
          labelText: "Quantity",
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.numbers), // Icon matching quantity
          controller: quantityController, // Corrected to use quantityController
        ),
        SizedBox(height: size.scaledHeight(1)),

        // Product Description Field
        TextFormField(
          controller: descriptionController,
          maxLines: null,
          minLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: "Enter Description",
            labelText: "Product Description",
            labelStyle: TextStyle(color: AppColors().appBlack),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.description), // Description icon
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors().appWhite,
          ),
        ),
      ],
    );
  }
}
