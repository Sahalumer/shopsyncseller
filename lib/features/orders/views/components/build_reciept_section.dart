import 'package:flutter/material.dart';

class BuildRecieptSection extends StatelessWidget {
  const BuildRecieptSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Receipt"), // Text constant
          Text("01"), // Sample data, use dynamic data here
        ],
      ),
    );
  }
}
