import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/view_model/bloc/bloc/auth_bloc.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_custom_tab_bar.dart';
import 'package:shopsyncseller/features/profile/view_models/bloc/store_details_bloc.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

class CustomProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomProductAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<StoreDetailsBloc>()
        .add(FetchStoreDetailsEvent(uid: globalUid!));
    context.read<AuthBloc>().add(FetchUserEvent());

    return BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
      builder: (context, storeState) {
        if (storeState is StoreDetailsEmpty) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is FetchSuccess) {
                return AppBar(
                  title: Text("Hi, ${authState.userModel.username}"),
                  actions: const [Icon(Icons.notifications)],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Container(
                      color: AppColors().appWhite,
                      child: const ProductCustomTabBar(),
                    ),
                  ),
                );
              }
              return AppBar();
            },
          );
        } else if (storeState is StoreDetailsLoaded) {
          return AppBar(
            title: Text(storeState.storeDetails.shopName),
            actions: const [Icon(Icons.notifications)],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: AppColors().appWhite,
                child: const ProductCustomTabBar(), // TabBar widget
              ),
            ),
          );
        }
        return AppBar();
      },
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 48.0); // Adjust the preferred size
}
