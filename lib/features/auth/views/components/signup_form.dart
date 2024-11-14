import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/model/user_model.dart';
import 'package:shopsyncseller/features/auth/services/show_auth_error.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/auth/views/widgets/auth_screen_button.dart';
import 'package:shopsyncseller/features/auth/views/widgets/auth_screens_textfields.dart';
import 'package:shopsyncseller/features/bottom_nav_bar/views/screens/bottom_nav_bar.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
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
          hintText: "Enter Username",
          keyboardType: TextInputType.name,
          labelText: "Username",
          controller: usernameController,
          prefixIcon: const Icon(Icons.person),
        ),
        SizedBox(height: mediaQuery.size.height * 0.01),
        AuthScreensTextfield(
          controller: emailController,
          hintText: "Enter Email",
          labelText: "Email",
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email),
        ),
        SizedBox(height: mediaQuery.size.height * 0.01),
        AuthScreensTextfield(
          controller: passwordController,
          prefixIcon: const Icon(Icons.lock),
          hintText: "Enter password",
          keyboardType: TextInputType.visiblePassword,
          labelText: "Password",
        ),
        SizedBox(height: mediaQuery.size.height * 0.015),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
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
            text: "Sign Up",
            function: () {
              final username = usernameController.text;
              final email = emailController.text;
              final password = passwordController.text;
              final userModel = UserModel(
                  username: username, email: email, userType: "Seller");

              context.read<AuthBloc>().add(SignUpEvent(userModel, password));
            },
          ),
        ),
      ],
    );
  }
}
