import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';

class CustomSupplierSearchBar extends StatefulWidget {
  final VoidCallback onClose;
  final FocusNode focusNode;

  const CustomSupplierSearchBar({
    super.key,
    required this.onClose,
    required this.focusNode,
  });

  @override
  State<CustomSupplierSearchBar> createState() =>
      _CustomSupplierSearchBarState();
}

class _CustomSupplierSearchBarState extends State<CustomSupplierSearchBar> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel(); // Cancel any active debounce timer
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false)
      _debounce!.cancel(); // Cancel if still active

    // Start a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SupplierBloc>().add(SearchSuppliers(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: widget.focusNode,
        controller: searchController,
        onChanged: _onSearchChanged, // Use the debounce method here
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: searchController.clear,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                ),
          hintText: "Search...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
