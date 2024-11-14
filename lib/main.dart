import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/services/firebase_auth_services.dart';
import 'package:shopsyncseller/features/auth/services/shared_preferences_services.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/features/profile/view_models/bloc/store_details_bloc.dart';
import 'package:shopsyncseller/features/splash/views/screens/splash_screens.dart';
import 'package:shopsyncseller/features/supplier/view_models/bloc/supplier_bloc.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final sharedPrefService = SharedPrefService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authService, sharedPrefService),
        ),
        BlocProvider(
          create: (context) => StoreDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => OfferProductBloc(),
        ),
        BlocProvider(
          create: (context) => SupplierBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: AppColors().appBackgroundColor,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
