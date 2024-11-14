import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/profile/views/widgets/profile_text_field.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class AddressFormComponents extends StatelessWidget {
  final TextEditingController landMarkController;
  final TextEditingController cityController;
  final TextEditingController districtController;
  final TextEditingController stateController;
  final TextEditingController pincodeController;
  const AddressFormComponents(
      {super.key,
      required this.landMarkController,
      required this.cityController,
      required this.districtController,
      required this.stateController,
      required this.pincodeController});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      children: [
        SizedBox(
          height: size.scaledHeight(1),
        ),
        ProfileTextField(
          controller: landMarkController,
          hintText: "Enter Landmark",
          labelText: "Landmark",
          keyboardType: TextInputType.text,
          prefixIcon: Icon(Icons.map),
        ),
        SizedBox(height: size.scaledHeight(1)),
        Row(
          children: [
            Expanded(
              child: ProfileTextField(
                controller: cityController,
                hintText: "Enter City",
                labelText: "City",
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            SizedBox(width: size.scaledWidth(2)),
            Expanded(
              child: ProfileTextField(
                controller: districtController,
                hintText: "Enter District",
                labelText: "District",
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ],
        ),
        SizedBox(height: size.scaledHeight(1)),
        Row(
          children: [
            Expanded(
              child: ProfileTextField(
                controller: stateController,
                hintText: "Enter State",
                labelText: "State",
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.map_outlined),
              ),
            ),
            SizedBox(width: size.scaledWidth(2)),
            Expanded(
              child: ProfileTextField(
                controller: pincodeController,
                hintText: "Enter Pincode",
                labelText: "Pincode",
                keyboardType: TextInputType.number,
                prefixIcon: Icon(Icons.pin_drop),
              ),
            ),
          ],
        ),
        SizedBox(height: size.scaledHeight(1)),
      ],
    );
  }
}
