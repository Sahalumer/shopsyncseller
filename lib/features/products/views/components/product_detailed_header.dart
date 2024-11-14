import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class ProductDetailedHeader extends StatefulWidget {
  final List<String> images;

  const ProductDetailedHeader({super.key, required this.images});

  @override
  _ProductDetailedHeaderState createState() => _ProductDetailedHeaderState();
}

class _ProductDetailedHeaderState extends State<ProductDetailedHeader> {
  int _currentIndex = 0; // Keep track of the current index

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex =
                    index; // Update the current index when the page changes
              });
            },
            itemBuilder: (context, index) {
              return Image.file(
                File(widget.images[index]),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
              );
            },
          ),
        ),
        _buildPageIndicators(widget.images.length, context),
      ],
    );
  }

  Widget _buildPageIndicators(int imageCount, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(imageCount, (index) {
        double size = _currentIndex == index ? 12.0 : 8.0;
        Color color =
            _currentIndex == index ? AppColors().appWhite : AppColors().appGrey;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
