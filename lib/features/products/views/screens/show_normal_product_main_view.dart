import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/features/products/views/components/normal_product_component.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ShowNormalProductMainView extends StatelessWidget {
  const ShowNormalProductMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductsLoaded) {
          return Padding(
            padding: size.scaledPadding(2, 1),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: List.generate(
                  state.products.length,
                  (index) {
                    return SizedBox(
                      width: size.scaledWidth(47.3),
                      child: NormalProductComponent(
                        productModel: state.products[index],
                        gridIndex: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmptyProduct) {
          return const Center(
            child: Text("No products Yet"),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Unexpected state: $state"),
              ElevatedButton(
                onPressed: () {
                  context.read<ProductBloc>().add(FetchProducts());
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      },
    );
  }
}
