import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/profile/view_models/bloc/store_details_bloc.dart';
import 'package:shopsyncseller/features/profile/views/components/after_store_details.dart';
import 'package:shopsyncseller/features/profile/views/components/before_save_details.dart';
import 'package:shopsyncseller/features/profile/views/components/profile_main_header.dart';
import 'package:shopsyncseller/features/profile/views/widgets/profile_header_shimmer_effect.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProfileMainView extends StatelessWidget {
  final String uid;
  const ProfileMainView({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    context.read<StoreDetailsBloc>().add(FetchStoreDetailsEvent(uid: uid));

    final size = CustomMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: size.scaledPadding(5, 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileMainHeader(),
              SizedBox(
                height: size.scaledHeight(10),
              ),
              BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                builder: (context, state) {
                  if (state is StoreDetailsLoading) {
                    return const ProfileHeaderShimmerEffect();
                  } else if (state is StoreDetailsEmpty) {
                    return const BeforeSaveDetails();
                  } else if (state is StoreDetailsLoaded) {
                    return AfterStoreDetails(
                      storeDetails: state.storeDetails,
                      uid: uid,
                    );
                  } else if (state is StoreDetailsError) {
                    return Text('Error: ${state.error}');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
