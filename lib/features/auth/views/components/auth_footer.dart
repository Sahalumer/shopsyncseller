import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback function;
  const AuthFooter(
      {super.key,
      required this.text,
      required this.buttonText,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        TextButton(
          onPressed: function,
          child: Text(
            buttonText,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
