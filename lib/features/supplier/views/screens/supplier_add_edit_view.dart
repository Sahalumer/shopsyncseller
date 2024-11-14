import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/features/supplier/views/componenets/add_supplier_form_components.dart';
import 'package:shopsyncseller/features/supplier/views/componenets/supplier_add_footer_components.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class SupplierAddEditView extends StatefulWidget {
  final SupplierModel? supplier;

  const SupplierAddEditView({super.key, this.supplier});

  @override
  State<SupplierAddEditView> createState() => _SupplierAddEditViewState();
}

class _SupplierAddEditViewState extends State<SupplierAddEditView> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.supplier != null) {
      final supplier = widget.supplier!;
      nameController.text = supplier.name;
      contactController.text = supplier.contact;
      cityController.text = supplier.city;
      districtController.text = supplier.district;
      stateController.text = supplier.state;
      pincodeController.text = supplier.pincode.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.supplier != null ? "Edit Supplier" : "Add Supplier",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: size.scaledPadding(2, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AddSupplierFormComponents(
                        nameController: nameController,
                        contactController: contactController,
                        cityController: cityController,
                        districtController: districtController,
                        stateController: stateController,
                        pincodeController: pincodeController),
                    SizedBox(height: size.scaledHeight(2)),
                    SupplierAddFooterComponents(
                      buttonText: widget.supplier != null ? 'Update' : 'Add',
                      onSubmit: _bottonClick,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bottonClick() {
    if (_formKey.currentState!.validate()) {
      try {
        final supplierData = SupplierModel(
          id: widget.supplier?.id,
          name: nameController.text.trim(),
          contact: contactController.text.trim(),
          city: cityController.text.trim(),
          district: districtController.text.trim(),
          state: stateController.text.trim(),
          pincode: int.parse(pincodeController.text.trim()),
        );

        if (widget.supplier == null) {
          context.read<SupplierBloc>().add(AddSupplier(supplierData));
        } else {
          context.read<SupplierBloc>().add(UpdateSupplier(supplierData));
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.supplier == null
                ? 'Supplier Added Successfully!'
                : 'Supplier Updated Successfully!'),
          ),
        );
        CustomNavigator.goBack(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Invalid pincode!'),
          ),
        );
      }
    }
  }
}
