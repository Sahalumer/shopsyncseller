import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsyncseller/features/auth/views/screens/login_screen.dart';
import 'package:shopsyncseller/features/bottom_nav_bar/views/screens/bottom_nav_bar.dart';
import 'package:shopsyncseller/features/splash/views/components/splash_components.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToScreen();
  }

  Future<void> _navigateToScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('uid');

    if (!mounted) return;

    if (username != null && username.isNotEmpty) {
      CustomNavigator.goTo(context, const BottomNavBarScreen(),
          isReplacement: true);
      globalUid = username;
    } else {
      CustomNavigator.goTo(context, const LoginScreen(), isReplacement: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SplashComponents(),
      ),
    );
  }
}
