import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/services/show_auth_error.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/auth/views/widgets/auth_screen_button.dart';
import 'package:shopsyncseller/features/auth/views/widgets/auth_screens_textfields.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().appBackgroundColor,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password reset email sent!')),
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
          } else if (state is AuthError) {
            showErrorAuth(context, state.message);
          }
        },
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.width * 0.06,
                vertical: mediaQuery.size.height * 0.12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'FORGET\nPASSWORD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.02),
                  const Text(
                    "Provide your account's email for which\n you want to reset your password!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.03),
                  AuthScreensTextfield(
                    hintText: "Enter Your Email",
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(height: mediaQuery.size.height * 0.015),
                  AuthScreensButton(
                    text: "Send",
                    function: () {
                      final email = emailController.text;
                      context.read<AuthBloc>().add(ResetPasswordEvent(email));
                    },
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
