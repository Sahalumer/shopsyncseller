import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/services/shared_preferences_services.dart';
import 'package:shopsyncseller/features/products/services/product_firebase_services.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/features/products/views/screens/offer_zone_product_view.dart';
import 'package:shopsyncseller/features/products/views/screens/product_add_edit_view.dart';
import 'package:shopsyncseller/features/products/views/screens/show_normal_product_main_view.dart';
import 'package:shopsyncseller/features/products/views/widgets/custom_product_app_bar.dart';
import 'package:shopsyncseller/features/profile/views/screens/add_edit_main_view.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';
import 'package:shopsyncseller/widgets/menu_drawer.dart';

class ProductsMainPage extends StatefulWidget {
  const ProductsMainPage({super.key});

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {
  String? uid;

  @override
  void initState() {
    super.initState();
    _storeUid();
  }

  Future<void> _storeUid() async {
    final String? val = await SharedPrefService().getUid();
    if (val != null) {
      setState(() {
        uid = val;
      });
    }
  }

  onFloatingPressed(BuildContext context) async {
    if (uid != null) {
      final bool isEligible =
          await ProductFirebaseServices().checkEligible(uid!);
      if (isEligible) {
        CustomNavigator.goTo(context, const ProductAddEditView());
      } else {
        _warningToAddStore(context);
      }
    }
  }

  void _warningToAddStore(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Store Details Required"),
        content: const Text(
          "You need to add store details before adding product information. "
          "Please update your store details in the profile section.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (uid != null) {
                CustomNavigator.goTo(context, AddEditMainView(uid: uid!));
              }
            },
            child: const Text("Add Now"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Later"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProducts());
    context.read<OfferProductBloc>().add(FetchOfferProducts());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomProductAppBar(),
        drawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onFloatingPressed(context);
          },
          child: const Icon(Icons.add),
        ),
        body: const TabBarView(
          children: [
            ShowNormalProductMainView(),
            OfferZoneProductView(),
          ],
        ),
      ),
    );
  }
}
