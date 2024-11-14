import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/profile/views/widgets/profile_text_field.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class AboutFormComponenet extends StatelessWidget {
  final TextEditingController contactController;
  final TextEditingController openInController;
  final TextEditingController closeInController;
  final TextEditingController descriptionController;
  const AboutFormComponenet(
      {super.key,
      required this.contactController,
      required this.openInController,
      required this.closeInController,
      required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Column(
      children: [
        ProfileTextField(
          controller: contactController,
          hintText: "Enter Contact Number",
          labelText: "Contact Number",
          keyboardType: TextInputType.phone,
          prefixIcon: Icon(Icons.phone),
        ),
        SizedBox(height: size.scaledHeight(1)),
        Row(
          children: [
            Expanded(
              child: ProfileTextField(
                controller: openInController,
                hintText: "(e.g., 9:00 AM)",
                labelText: "Opening Time",
                keyboardType: TextInputType.datetime,
                prefixIcon: Icon(Icons.access_time),
              ),
            ),
            SizedBox(width: size.scaledWidth(2)),
            Text(
              "To",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: size.scaledWidth(2)),
            Expanded(
              child: ProfileTextField(
                controller: closeInController,
                hintText: "(e.g., 9:00 PM)",
                labelText: "Closing Time",
                keyboardType: TextInputType.datetime,
                prefixIcon: Icon(Icons.access_time),
              ),
            ),
          ],
        ),
        SizedBox(height: size.scaledHeight(1)),
        TextFormField(
          controller: descriptionController,
          maxLines: null,
          minLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: "Enter Shop Description",
            labelText: "Shop Description",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(Icons.description),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors().appWhite,
          ),
        ),
      ],
    );
  }
}
