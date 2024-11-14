import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class ProductTextFiled extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final Icon prefixIcon;
  final TextEditingController controller;
  const ProductTextFiled({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    required this.prefixIcon,
    required this.controller,
  });

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $labelText';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColors().appBlack,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors().appBlack,
        filled: true,
        fillColor: AppColors().appWhite,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: _validator,
    );
  }
}
