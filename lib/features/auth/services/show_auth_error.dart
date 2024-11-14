import 'package:flutter/material.dart';

void showErrorAuth(BuildContext context, String errorMessage) {
  String message;

  switch (errorMessage) {
    case 'invalid-credential':
      message = 'Invalid Email or Password.';
      break;
    case 'email-already-in-use':
      message = 'Email is already in use.';
      break;
    case 'weak-password':
      message = '6 characters are required for password.';
      break;

    default:
      message = 'Authentication error occurred. Please try again.';
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
