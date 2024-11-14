import 'package:flutter/material.dart';

class CustomMediaQuery {
  final BuildContext context;

  CustomMediaQuery(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  bool get isPortrait =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  double get blockSizeHorizontal => screenWidth / 100;
  double get blockSizeVertical => screenHeight / 100;

  double scaledWidth(double percentage) => screenWidth * (percentage / 100);
  double scaledHeight(double percentage) => screenHeight * (percentage / 100);

  EdgeInsets scaledPadding(
      double horizontalPercentage, double verticalPercentage) {
    return EdgeInsets.symmetric(
      horizontal: screenWidth * (horizontalPercentage / 100),
      vertical: screenHeight * (verticalPercentage / 100),
    );
  }
}
