import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/bottom_nav_bar/views/components/bar_items.dart';
import 'package:shopsyncseller/features/bottom_nav_bar/views/components/bar_label_items.dart';
import 'package:shopsyncseller/features/chat/views/screens/chat_main_page.dart';
import 'package:shopsyncseller/features/home/views/screens/home_screen.dart';
import 'package:shopsyncseller/features/inventory/views/screens/inventroy_main_page.dart';
import 'package:shopsyncseller/features/orders/views/screens/orders_main_page.dart';
import 'package:shopsyncseller/features/products/views/screens/products_main_page.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProductsMainPage(),
    OrdersMainPage(),
    InventroyMainPage(),
    ChatMainPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CurvedNavigationBar(
              items: navItems,
              index: _selectedIndex,
              backgroundColor: AppColors().appBackgroundColor,
              onTap: _onItemTapped,
            ),
            const BarLabelItems()
          ],
        ),
      ),
    );
  }
}


// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:sellershopsync/features/bottom_nav_bar/views/components/bar_items.dart';
// import 'package:sellershopsync/features/chat/views/screens/chat_main_page.dart';
// import 'package:sellershopsync/features/home/views/screens/home_screen.dart';
// import 'package:sellershopsync/features/inventory/views/screens/inventroy_main_page.dart';
// import 'package:sellershopsync/features/orders/views/screens/orders_main_page.dart';
// import 'package:sellershopsync/features/products/views/screens/products_main_page.dart';
// import 'package:sellershopsync/utils/constants/application_colors.dart';

// class BottomNavBarScreen extends StatefulWidget {
//   const BottomNavBarScreen({super.key});

//   @override
//   State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
// }

// class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     ProductsMainPage(),
//     OrdersMainPage(),
//     InventroyMainPage(),
//     ChatMainPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: _widgetOptions.elementAt(_selectedIndex),
//         bottomNavigationBar: ConvexAppBar(
//           style: TabStyle.react,
//           height: 60,

//           items: navTabItems,
//           initialActiveIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           backgroundColor: AppColors().appWhite,
//           activeColor: Colors.black,
//           color: Colors.grey[600],
//         ),
//       ),
//     );
//   }
// }
