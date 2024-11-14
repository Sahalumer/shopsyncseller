import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class UnitMenuDrawer extends StatefulWidget {
  final List<String> units;
  final TextEditingController unitController;

  const UnitMenuDrawer({
    super.key,
    required this.units,
    required this.unitController,
  });

  @override
  State<UnitMenuDrawer> createState() => _UnitMenuDrawerState();
}

class _UnitMenuDrawerState extends State<UnitMenuDrawer> {
  String? _selectedUnit;

  @override
  void initState() {
    super.initState();

    _selectedUnit = widget.unitController.text.isNotEmpty
        ? widget.unitController.text
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: 'Choose One',
        labelText: 'Unit',
        labelStyle: TextStyle(
          color: AppColors().appBlack,
        ),
        filled: true,
        fillColor: AppColors().appWhite,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 12.0,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedUnit,
          hint: const Text("Unit"),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _selectedUnit = newValue;
              widget.unitController.text = newValue ?? '';
            });
          },
          items: widget.units.map<DropdownMenuItem<String>>((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(unit),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
