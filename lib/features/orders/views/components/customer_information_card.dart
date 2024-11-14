import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/orders/views/widgets/build_info_row.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class CustomerInformationCard extends StatelessWidget {
  const CustomerInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.blue[900],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "John Son",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors().appWhite,
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            const SizedBox(height: 10),
            BuildInfoRow(
              icon: Icons.location_city,
              label: "City:",
              value: "Kunnamangalam",
            ),
            BuildInfoRow(
              icon: Icons.location_on,
              label: "District:",
              value: "Kozhikode",
            ),
            BuildInfoRow(
              icon: Icons.map,
              label: "State:",
              value: "Kerala",
            ),
            BuildInfoRow(
              icon: Icons.code,
              label: "Pincode:",
              value: "673571",
            ),
            const SizedBox(height: 10),
            BuildInfoRow(
              icon: Icons.phone,
              label: 'Phone Number:',
              value: "8590568213",
            ),
          ],
        ),
      ),
    );
  }
}
