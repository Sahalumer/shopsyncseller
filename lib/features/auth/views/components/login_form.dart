import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/services/show_auth_error.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/auth/views/screens/forgot_password_screen.dart';
import 'package:shopsyncseller/features/auth/views/widgets/auth_screen_button.dart';
import 'package:shopsyncseller/features/auth/views/widgets/auth_screens_textfields.dart';
import 'package:shopsyncseller/features/bottom_nav_bar/views/screens/bottom_nav_bar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        AuthScreensTextfield(
          controller: emailController,
          hintText: "Enter Email",
          labelText: "Email",
          prefixIcon: const Icon(Icons.email),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.01,
        ),
        AuthScreensTextfield(
          hintText: "Enter Password",
          labelText: "Password",
          controller: passwordController,
          prefixIcon: const Icon(Icons.lock),
          keyboardType: TextInputType.visiblePassword,
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.015,
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            } else if (state is AuthSuccess) {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const BottomNavBarScreen()),
              );
            } else if (state is AuthError) {
              Navigator.pop(context);

              showErrorAuth(context, state.message);
            }
          },
          child: AuthScreensButton(
            text: "Login",
            function: () {
              final email = emailController.text;
              final password = passwordController.text;

              context.read<AuthBloc>().add(LoginEvent(email, password));
            },
          ),
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.11,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: const Text(
            "Forgot Password?..",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
