import 'package:flutter/material.dart';

class BarLabelItems extends StatelessWidget {
  const BarLabelItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10, left: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Home',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text('Products',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text('Orders',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text('Inventory',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text('Chat',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
