import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/profile/views/widgets/profile_header_shimmer_effect.dart';

class ProfileMainHeader extends StatelessWidget {
  const ProfileMainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is FetchSuccess) {
          return Column(
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(
                  state.userModel.username[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                state.userModel.username,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(state.userModel.email),
            ],
          );
        } else if (state is AuthLoading) {
          return const Center(
            child: ProfileHeaderShimmerEffect(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
