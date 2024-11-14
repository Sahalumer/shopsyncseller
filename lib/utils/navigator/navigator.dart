import 'package:flutter/material.dart';

class CustomNavigator {
  static void goTo(BuildContext context, Widget page,
      {bool isReplacement = false}) {
    if (isReplacement) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }

  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void goToWithFade(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void goToWithSlide(BuildContext context, Widget page,
      {AxisDirection direction = AxisDirection.left}) {
    final slideOffset = getOffsetFromDirection(direction);
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(Tween<Offset>(
              begin: slideOffset,
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.ease))),
            child: child,
          );
        },
      ),
    );
  }

  static Offset getOffsetFromDirection(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
      default:
        return const Offset(1, 0);
    }
  }
}
