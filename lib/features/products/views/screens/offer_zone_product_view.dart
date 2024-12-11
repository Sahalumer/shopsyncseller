import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/views/components/offer_product_components.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class OfferZoneProductView extends StatelessWidget {
  const OfferZoneProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return BlocListener<OfferProductBloc, OfferProductState>(
      listener: (context, state) {
        if (state is OfferProductOperationSuccess) {
          context.read<OfferProductBloc>().add(FetchOfferProducts());
        }
      },
      child: BlocBuilder<OfferProductBloc, OfferProductState>(
        builder: (context, state) {
          if (state is OfferProductLoaded) {
            return _buildProductGrid(state.products, size);
          } else if (state is EmptyOfferProduct) {
            return const Center(child: Text("No offers yet"));
          } else if (state is OfferProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Unexpected state: $state"),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<OfferProductBloc>()
                          .add(FetchOfferProducts());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductGrid(List products, CustomMediaQuery size) {
    return SingleChildScrollView(
      child: Padding(
        padding: size.scaledPadding(2, 1),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: List.generate(products.length, (index) {
            return SizedBox(
              width: size.scaledWidth(47.3),
              child: OfferProductComponents(
                gridIndex: index,
                product: products[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
