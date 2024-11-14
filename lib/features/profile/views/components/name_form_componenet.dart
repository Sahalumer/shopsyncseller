import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/profile/views/widgets/profile_text_field.dart';

class NameFormComponenet extends StatelessWidget {
  final TextEditingController shopNameController;
  const NameFormComponenet({super.key, required this.shopNameController});

  @override
  Widget build(BuildContext context) {
    return ProfileTextField(
      hintText: "Enter Shop Name",
      controller: shopNameController,
      labelText: "Shop Name",
      keyboardType: TextInputType.name,
      prefixIcon: Icon(Icons.store),
    );
  }
}
