import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/profile/view_models/bloc/store_details_bloc.dart';
import 'package:shopsyncseller/features/profile/views/screens/add_edit_main_view.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class ShowDetailsMiniComponent extends StatelessWidget {
  final String uid;
  const ShowDetailsMiniComponent({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    // context.read<StoreDetailsBloc>().add(FetchStoreDetailsEvent(uid: uid));
    final size = CustomMediaQuery(context);

    return BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
      builder: (context, state) {
        if (state is StoreDetailsLoaded) {
          return Container(
            padding: EdgeInsets.all(16.0),
            width: size.screenWidth,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.scaledHeight(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.storeDetails.shopName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {
                            CustomNavigator.goTo(
                                context,
                                AddEditMainView(
                                  uid: uid,
                                  storeDetailsModel: state.storeDetails,
                                ));
                          },
                          icon: Icon(Icons.edit),
                        )
                      ],
                    ),
                    Text(
                        "${state.storeDetails.openIn} - ${state.storeDetails.closeIn}"),
                    SizedBox(height: size.scaledHeight(1)),
                    Text(state.storeDetails.shopDescription),
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(state.storeDetails.landMark),
                    Text(
                        "${state.storeDetails.city}, ${state.storeDetails.district}"),
                    Text(
                        "${state.storeDetails.state}, ${state.storeDetails.pincode}"),
                    SizedBox(
                      height: size.scaledHeight(1),
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(state.storeDetails.contact)
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
