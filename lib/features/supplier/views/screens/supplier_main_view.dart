import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/features/supplier/views/componenets/search_components.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_add_edit_view.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_detailed_view.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class SupplierMainView extends StatefulWidget {
  final String? productId;
  String? supplierId;
  SupplierMainView({super.key, this.productId, this.supplierId});

  @override
  State<SupplierMainView> createState() => _SupplierMainViewState();
}

class _SupplierMainViewState extends State<SupplierMainView> {
  bool isSearch = false;
  final FocusNode searchFocusNode = FocusNode();
  SupplierModel? selectedSupplier;

  @override
  void initState() {
    super.initState();
    context.read<SupplierBloc>().add(FetchSuppliers());
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  void toggleSearch() {
    setState(() {
      isSearch = !isSearch;
      if (isSearch) {
        searchFocusNode.requestFocus();
      } else {
        searchFocusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suppliers",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: toggleSearch,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: selectedSupplier == null
            ? FloatingActionButton(
                key: const ValueKey('addButton'),
                onPressed: () {
                  CustomNavigator.goTo(
                    context,
                    const SupplierAddEditView(),
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
      body: Column(
        children: [
          if (isSearch)
            CustomSupplierSearchBar(
              focusNode: searchFocusNode,
              onClose: toggleSearch,
            ),
          Expanded(
            child: BlocBuilder<SupplierBloc, SupplierState>(
              builder: (context, state) {
                if (state is SupplierLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmptySupplier) {
                  return const Center(child: Text("No suppliers available"));
                } else if (state is SuppliersLoaded) {
                  return Column(
                    children: [
                      Expanded(child: buildSupplierList(state.suppliers, size)),
                      if (selectedSupplier != null)
                        InkWell(
                          onTap: () {
                            updateProductSuppliers();
                          },
                          child: Container(
                            height: size.scaledHeight(8),
                            width: size.scaledWidth(60),
                            decoration: BoxDecoration(
                                color: AppColors().appBlack,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  color: AppColors().appWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: size.scaledHeight(1),
                      )
                    ],
                  );
                } else {
                  return Center(child: Text("Unexpected state $state"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupplierList(
      List<SupplierModel> suppliers, CustomMediaQuery size) {
    return ListView.builder(
      itemCount: suppliers.length,
      itemBuilder: (context, index) {
        final supplier = suppliers[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.scaledWidth(2),
            vertical: size.scaledHeight(1),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors().appWhite,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: const Icon(Icons.store, size: 36, color: Colors.blue),
              title: Text(supplier.name),
              subtitle: Text(supplier.city),
              trailing: widget.productId != null || widget.supplierId != null
                  ? Checkbox(
                      value: selectedSupplier?.id == supplier.id,
                      onChanged: (isChecked) {
                        if (isChecked == true) {
                          setState(() {
                            selectedSupplier = supplier;
                          });
                        } else {
                          setState(() {
                            selectedSupplier = null;
                          });
                        }
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context
                            .read<SupplierBloc>()
                            .add(DeleteSupplier(supplier.id!));
                      },
                    ),
              onTap: () {
                CustomNavigator.goTo(
                  context,
                  SupplierDetailedView(
                    supplierId: supplier.id!,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void updateProductSuppliers() {
    if (selectedSupplier != null) {
      Navigator.pop(context, selectedSupplier!.id);
    }
  }
}
