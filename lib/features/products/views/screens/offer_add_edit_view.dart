import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/offer_model.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/services/product_firebase_services.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_text_filed.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

class OfferDialog extends StatefulWidget {
  final String? productId;
  final ProductModel? productModel;

  const OfferDialog({super.key, this.productId, this.productModel});

  @override
  State<OfferDialog> createState() => _OfferDialogState();
}

class _OfferDialogState extends State<OfferDialog> {
  final priceController = TextEditingController();
  final buyController = TextEditingController();
  final getController = TextEditingController();

  bool isBuyGetOffer = false;
  bool isSpecialPrice = false;
  bool isUpdate = false;
  OfferProductModel? offerProduct;

  @override
  void dispose() {
    priceController.dispose();
    buyController.dispose();
    getController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  Future<void> _initializeValues() async {
    if (widget.productModel != null) {
      offerProduct = OfferProductModel(
        productName: widget.productModel!.productName,
        price: widget.productModel!.price,
        description: widget.productModel!.description,
        pictures: widget.productModel!.pictures,
        reviews: widget.productModel!.reviews,
        unit: widget.productModel!.unit,
        reviewGraph: widget.productModel!.reviewGraph,
        quantity: widget.productModel!.quantity,
      );
    }

    if (widget.productId != null) {
      final fetchedOffer = await ProductFirebaseServices()
          .fetchOfferProductById(globalUid!, widget.productId!);

      if (fetchedOffer != null) {
        setState(() {
          offerProduct = fetchedOffer;
          isUpdate = true;
          _assignOfferValues(fetchedOffer.offer);
        });
      }
    }
  }

  void _assignOfferValues(Offer? offer) {
    if (offer == null) return;

    if (offer.isBuyGetOffer) {
      isBuyGetOffer = true;
      buyController.text = offer.buyQuantity.toString();
      getController.text = offer.getQuantity.toString();
    }

    if (offer.isSpecialOffer) {
      isSpecialPrice = true;
      priceController.text = offer.offerPrice.toString();
    }
  }

  void _submitOffer() {
    if (isSpecialPrice && priceController.text.isEmpty) {
      _showError("Please enter an offer price.");
      return;
    }

    if (isBuyGetOffer &&
        (buyController.text.isEmpty || getController.text.isEmpty)) {
      _showError("Please enter both buy and get quantities.");
      return;
    }

    final offerPrice =
        isSpecialPrice ? double.tryParse(priceController.text) : null;
    final buyQuantity = isBuyGetOffer ? int.tryParse(buyController.text) : null;
    final getQuantity = isBuyGetOffer ? int.tryParse(getController.text) : null;

    if (offerPrice == null && isSpecialPrice) {
      _showError("Invalid offer price.");
      return;
    }
    if ((buyQuantity == null || getQuantity == null) && isBuyGetOffer) {
      _showError("Invalid buy/get quantities.");
      return;
    }

    final offer = Offer(
      isBuyGetOffer: isBuyGetOffer,
      isSpecialOffer: isSpecialPrice,
      buyQuantity: buyQuantity,
      getQuantity: getQuantity,
      offerPrice: offerPrice,
    );

    if (isUpdate) {
      context
          .read<OfferProductBloc>()
          .add(UpdateOffer(widget.productId!, offer));
    } else {
      context
          .read<OfferProductBloc>()
          .add(AddOffer(offer, widget.productModel!));
    }

    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Move to Offer Zone",
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              value: isSpecialPrice,
              onChanged: (value) {
                setState(() {
                  isSpecialPrice = value ?? false;
                });
              },
              title: const Text("Special Price"),
            ),
            if (isSpecialPrice)
              ProductTextFiled(
                controller: priceController,
                hintText: "Enter Offer Price",
                labelText: "Offer Price",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.attach_money),
              ),
            const SizedBox(height: 10),
            CheckboxListTile(
              value: isBuyGetOffer,
              onChanged: (value) {
                setState(() {
                  isBuyGetOffer = value ?? false;
                });
              },
              title: const Text("Buy Get Free"),
            ),
            if (isBuyGetOffer)
              Row(
                children: [
                  Expanded(
                    child: ProductTextFiled(
                      controller: buyController,
                      hintText: "Buy Quantity",
                      labelText: "Buy",
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.shopping_basket),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ProductTextFiled(
                      controller: getController,
                      hintText: "Get Quantity",
                      labelText: "Get",
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.card_giftcard),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _submitOffer,
          child: const Text("Save"),
        ),
      ],
    );
  }
}
