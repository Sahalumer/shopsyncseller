import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/orders/views/screens/pending_order_main_view.dart';
import 'package:shopsyncseller/features/orders/views/screens/processing_orders_main_view.dart';
import 'package:shopsyncseller/features/orders/views/screens/shipped_orders_main_page.dart';
import 'package:shopsyncseller/features/orders/views/widgets/custom_tab_bar_widget.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/widgets/menu_drawer.dart';

class OrdersMainPage extends StatelessWidget {
  const OrdersMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().appWhite,
          title: const Text("Orders"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Container(
              color: AppColors().appWhite,
              child: const CustomTabBarWidget(),
            ),
          ),
        ),
        drawer: const CustomDrawer(),
        body: const TabBarView(
          children: [
            PendingOrderMainView(),
            ProcessingOrdersMainView(),
            ShippedOrdersMainPage(),
          ],
        ),
      ),
    );
  }
}
