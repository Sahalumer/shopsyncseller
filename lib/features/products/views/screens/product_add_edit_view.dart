import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/models/review_model.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/features/products/views/components/product_checkbox_component.dart';
import 'package:shopsyncseller/features/products/views/components/product_form_field_component.dart';
import 'package:shopsyncseller/features/products/views/components/product_form_footer.dart';
import 'package:shopsyncseller/features/products/views/components/product_form_header.dart';
import 'package:shopsyncseller/features/products/views/screens/offer_add_edit_view.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/features/supplier/services/suppllier_firebase_services.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_main_view.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class ProductAddEditView extends StatefulWidget {
  final ProductModel? product;
  final OfferProductModel? offerProduct;

  const ProductAddEditView({
    super.key,
    this.product,
    this.offerProduct,
  });

  @override
  State<ProductAddEditView> createState() => _ProductAddEditViewState();
}

class _ProductAddEditViewState extends State<ProductAddEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final unitController = TextEditingController();
  final quantityController = TextEditingController();

  bool isOffer = false;
  bool isSupplier = false;
  String? supplierId = "sample";
  List<String> pictures = [];
  List<ReviewModel> reviews = [];
  Map<int, int> reviewGraph = {};
  SupplierModel? supplierModel;
  late bool isNeed;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    unitController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void _initializeForm() {
    isNeed = widget.product == null && widget.offerProduct == null;

    if (widget.product != null) {
      _populateProductFields(widget.product!);
    } else if (widget.offerProduct != null) {
      _populateOfferProductFields(widget.offerProduct!);
    }
  }

  void _populateProductFields(ProductModel product) {
    productNameController.text = product.productName;
    descriptionController.text = product.description;
    priceController.text = product.price.toString();
    unitController.text = product.unit;
    quantityController.text = product.quantity.toString();
    pictures = product.pictures;
    reviews = product.reviews;
    reviewGraph = product.reviewGraph;
  }

  void _populateOfferProductFields(OfferProductModel offerProduct) {
    _populateProductFields(offerProduct as ProductModel);
    supplierModel = offerProduct.supplier;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final product = _buildProductModel();

      if (isNeed) {
        await _addProduct(product);
      } else {
        await _updateProduct(product);
      }
    }
  }

  ProductModel _buildProductModel() {
    return ProductModel(
      id: widget.product?.id,
      productName: productNameController.text,
      description: descriptionController.text,
      pictures: pictures,
      price: double.tryParse(priceController.text) ?? 0.0,
      quantity: int.tryParse(quantityController.text) ?? 0,
      unit: unitController.text,
      reviewGraph: reviewGraph,
      reviews: reviews,
    );
  }

  Future<void> _addProduct(ProductModel product) async {
    context.read<ProductBloc>().add(AddProduct(product));

    final productId = await context
        .read<ProductBloc>()
        .stream
        .firstWhere((state) => state is ProductAddedSuccessfully)
        .then((state) => (state as ProductAddedSuccessfully).productId);

    final supplier = await _fetchAndUpdateSupplier(productId);
    if (supplier != null) {
      context.read<SupplierBloc>().add(UpdateSupplier(supplier));
    }

    if (isOffer) {
      _navigateToOfferDialog(product);
    } else {
      CustomNavigator.goBack(context);
    }
  }

  Future<SupplierModel?> _fetchAndUpdateSupplier(String productId) async {
    final supplier = await SupplierFirebaseServices()
        .fetchSingleSupplierById(globalUid!, supplierId!);
    if (supplier != null) {
      supplier.products.add(productId);
    }
    return supplier;
  }

  Future<void> _updateProduct(ProductModel product) async {
    if (widget.product != null) {
      context.read<ProductBloc>().add(UpdateProduct(product));
    } else if (widget.offerProduct != null) {
      final offerProduct = OfferProductModel(
        id: widget.offerProduct!.id,
        productName: product.productName,
        description: product.description,
        pictures: product.pictures,
        price: product.price,
        quantity: product.quantity,
        unit: product.unit,
        reviewGraph: product.reviewGraph,
        reviews: product.reviews,
        supplier: supplierModel,
        offer: widget.offerProduct!.offer,
      );
      context.read<OfferProductBloc>().add(UpdateOfferProduct(offerProduct));
    }
    CustomNavigator.goBack(context);
  }

  void _navigateToOfferDialog(ProductModel product) {
    CustomNavigator.goTo(
      context,
      OfferDialog(productModel: product),
      isReplacement: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isNeed ? "Add Product" : "Update Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: size.scaledPadding(3, 1),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProductFormHeader(images: pictures),
                const SizedBox(height: 10),
                ProductFormFieldComponent(
                  descriptionController: descriptionController,
                  nameController: productNameController,
                  priceController: priceController,
                  unitController: unitController,
                  quantityController: quantityController,
                ),
                SizedBox(height: size.scaledHeight(2)),
                ProductCheckboxComponent(
                  isNeed: isNeed,
                  isOffer: isOffer,
                  onIsOfferChanged: (value) => setState(() => isOffer = value),
                  onIsSupplierChanged: (value) =>
                      setState(() => isSupplier = value),
                  isSupplier: isSupplier,
                ),
                if (isSupplier)
                  TextButton(
                    onPressed: () async {
                      final selectedSupplierId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SupplierMainView(supplierId: supplierId),
                        ),
                      );

                      if (selectedSupplierId != null) {
                        setState(() {
                          supplierId = selectedSupplierId;
                        });
                      }
                    },
                    child: const Text("Add Supplier"),
                  ),
                ProductFormFooter(
                  buttonText: isNeed ? "Add" : "Update",
                  onSubmit: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
