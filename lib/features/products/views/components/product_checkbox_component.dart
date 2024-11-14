import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductCheckboxComponent extends StatefulWidget {
  final bool isNeed;
  final bool isOffer;
  final ValueChanged<bool> onIsOfferChanged;
  final ValueChanged<bool> onIsSupplierChanged;
  final bool isSupplier;
  const ProductCheckboxComponent(
      {super.key,
      required this.isNeed,
      required this.isOffer,
      required this.onIsOfferChanged,
      required this.onIsSupplierChanged,
      required this.isSupplier});

  @override
  State<ProductCheckboxComponent> createState() =>
      _ProductCheckboxComponentState();
}

class _ProductCheckboxComponentState extends State<ProductCheckboxComponent> {
  late bool _isOffer;
  late bool _isSupplier;

  @override
  void initState() {
    super.initState();
    _isOffer = widget.isOffer;
    _isSupplier = widget.isSupplier;
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _isSupplier,
              onChanged: (value) {
                setState(() {
                  _isSupplier = value ?? false;
                });
                widget.onIsSupplierChanged(_isSupplier);
              },
            ),
            Flexible(
              child: const Text(
                "Do you want to save information about the supplier?",
              ),
            ),
          ],
        ),
        SizedBox(height: size.scaledHeight(2)),
        if (widget.isNeed)
          Row(
            children: [
              Checkbox(
                value: _isOffer,
                onChanged: (value) {
                  setState(() {
                    _isOffer = value ?? false;
                  });
                  widget.onIsOfferChanged(_isOffer);
                },
              ),
              const Text(
                "Is this item being added to the Offer Zone?",
              ),
            ],
          ),
        SizedBox(height: size.scaledHeight(2)),
      ],
    );
  }
}
