import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/profile/models/store_details_model.dart';
import 'package:shopsyncseller/features/profile/view_models/bloc/store_details_bloc.dart';
import 'package:shopsyncseller/features/profile/views/components/about_form_componenet.dart';
import 'package:shopsyncseller/features/profile/views/components/address_form_components.dart';
import 'package:shopsyncseller/features/profile/views/components/footer_form_components.dart';
import 'package:shopsyncseller/features/profile/views/components/name_form_componenet.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class AddEditMainView extends StatefulWidget {
  final StoreDetailsModel? storeDetailsModel;
  final String uid;

  const AddEditMainView({
    super.key,
    this.storeDetailsModel,
    required this.uid,
  });

  @override
  _AddEditMainViewState createState() => _AddEditMainViewState();
}

class _AddEditMainViewState extends State<AddEditMainView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController shopNameController;
  late final TextEditingController landMarkController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  late final TextEditingController stateController;
  late final TextEditingController pincodeController;
  late final TextEditingController contactController;
  late final TextEditingController openInController;
  late final TextEditingController closeInController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with store details or empty values
    shopNameController =
        TextEditingController(text: widget.storeDetailsModel?.shopName ?? '');
    landMarkController =
        TextEditingController(text: widget.storeDetailsModel?.landMark ?? '');
    cityController =
        TextEditingController(text: widget.storeDetailsModel?.city ?? '');
    districtController =
        TextEditingController(text: widget.storeDetailsModel?.district ?? '');
    stateController =
        TextEditingController(text: widget.storeDetailsModel?.state ?? '');
    pincodeController =
        TextEditingController(text: widget.storeDetailsModel?.pincode ?? '');
    contactController =
        TextEditingController(text: widget.storeDetailsModel?.contact ?? '');
    openInController =
        TextEditingController(text: widget.storeDetailsModel?.openIn ?? '');
    closeInController =
        TextEditingController(text: widget.storeDetailsModel?.closeIn ?? '');
    descriptionController = TextEditingController(
        text: widget.storeDetailsModel?.shopDescription ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    shopNameController.dispose();
    landMarkController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    contactController.dispose();
    openInController.dispose();
    closeInController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final newStoreDetails = StoreDetailsModel(
        shopName: shopNameController.text,
        landMark: landMarkController.text,
        city: cityController.text,
        district: districtController.text,
        state: stateController.text,
        pincode: pincodeController.text,
        contact: contactController.text,
        openIn: openInController.text,
        closeIn: closeInController.text,
        shopDescription: descriptionController.text,
      );

      context
          .read<StoreDetailsBloc>()
          .add(AddOrUpdateStoreEvent(newStoreDetails, widget.uid));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: size.scaledPadding(3, 1),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                NameFormComponenet(shopNameController: shopNameController),
                AddressFormComponents(
                  cityController: cityController,
                  districtController: districtController,
                  landMarkController: landMarkController,
                  pincodeController: pincodeController,
                  stateController: stateController,
                ),
                AboutFormComponenet(
                  closeInController: closeInController,
                  contactController: contactController,
                  descriptionController: descriptionController,
                  openInController: openInController,
                ),
                FooterFormComponents(
                  buttonText:
                      widget.storeDetailsModel != null ? "Update" : "Add",
                  onSubmit: _onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
