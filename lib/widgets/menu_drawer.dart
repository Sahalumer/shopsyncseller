import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/model/user_model.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/auth/views/screens/login_screen.dart';
import 'package:shopsyncseller/features/profile/views/screens/profile_main_view.dart';
import 'package:shopsyncseller/features/qr_code/views/screens/qr_main_view.dart';
import 'package:shopsyncseller/features/supplier/views/screens/supplier_main_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).add(FetchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You have been logged out.')),
          );
        } else if (state is FetchSuccess) {
          setState(() {
            userModel = state.userModel;
          });
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Drawer(
        child: Column(
          children: [
            _buildHeader(),
            _buildListTile(
              icon: Icons.person,
              title: "Profile",
              onTap: () {
                Navigator.pop(context);
                if (userModel?.uid != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ProfileMainView(uid: userModel!.uid!),
                    ),
                  );
                }
              },
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.store,
              title: 'Supplier',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SupplierMainView(),
                  ),
                );
              },
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.qr_code,
              title: 'QR Code',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => QrMainView()),
                );
              },
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.privacy_tip,
              title: 'Privacy and Policy',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            _buildListTile(
              icon: Icons.info,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              userModel != null && userModel!.username.isNotEmpty
                  ? userModel!.username[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            userModel != null ? 'Welcome, ${userModel!.username}!' : 'Welcome!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            userModel?.email ?? 'Loading...',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
            },
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
