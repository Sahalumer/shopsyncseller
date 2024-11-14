import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/auth/views/components/auth_footer.dart';
import 'package:shopsyncseller/features/auth/views/components/auth_screen_header.dart';
import 'package:shopsyncseller/features/auth/views/components/signup_form.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().appBackgroundColor,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.width * 0.06,
                vertical: mediaQuery.size.height * 0.10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthScreenHeader(
                    title: "Sign up",
                    subtitle: 'Create your account',
                  ),
                  SizedBox(height: 50),
                  SignupForm(),
                  SizedBox(height: 40),
                  AuthFooter(
                    text: "Already have an account?",
                    buttonText: "Login",
                    function: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
