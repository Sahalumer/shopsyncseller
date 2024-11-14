import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/home/views/widgets/custom_container.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/features/home/views/widgets/custom_appbar.dart';
import 'package:shopsyncseller/widgets/menu_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = CustomMediaQuery(context);
    return Scaffold(
        appBar: const CustomeHomeAppbar(),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: mediaQuery.scaledPadding(3, 1.5),
          child: Column(
            children: [
              Row(
                children: [
                  const CustomGrid(
                    icon: Icons.inventory_outlined,
                    text: "Inventory Alerts",
                  ),
                  SizedBox(
                    width: mediaQuery.scaledWidth(2),
                  ),
                  const CustomGrid(
                    icon: Icons.local_shipping,
                    text: "Total Orders",
                  ),
                ],
              ),
              SizedBox(
                height: mediaQuery.scaledHeight(1),
              ),
              Row(
                children: [
                  const CustomGrid(
                    icon: Icons.inventory,
                    text: "Products",
                  ),
                  SizedBox(
                    width: mediaQuery.scaledWidth(2),
                  ),
                  const CustomGrid(
                    icon: Icons.people,
                    text: "Suppliers",
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
