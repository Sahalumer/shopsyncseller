import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/auth/views/components/auth_footer.dart';
import 'package:shopsyncseller/features/auth/views/components/auth_screen_header.dart';
import 'package:shopsyncseller/features/auth/views/components/login_form.dart';
import 'package:shopsyncseller/features/auth/views/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.width * 0.06,
                vertical: mediaQuery.size.height * 0.12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AuthScreenHeader(
                      title: "Welcome Back",
                      subtitle: "Enter your credentials to login"),
                  SizedBox(
                    height: mediaQuery.size.height * 0.12,
                  ),
                  const LoginForm(),
                  SizedBox(
                    height: mediaQuery.size.height * 0.06,
                  ),
                  AuthFooter(
                    text: "Don't have an account?",
                    buttonText: "Sign Up",
                    function: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const SignupScreen(),
                      ),
                    ),
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
