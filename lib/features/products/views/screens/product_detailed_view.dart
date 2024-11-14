import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/models/review_model.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/features/products/views/components/Product_detailed_details.dart';
import 'package:shopsyncseller/features/products/views/components/product_detail_footer.dart';
import 'package:shopsyncseller/features/products/views/components/product_detailed_header.dart';
import 'package:shopsyncseller/features/products/views/components/product_reviews.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_delete_msg.dart';
import 'package:shopsyncseller/utils/navigator/navigator.dart';

class ProductDetailedView extends StatelessWidget {
  final String productid;
  final int gridIndex;

  const ProductDetailedView({
    super.key,
    required this.productid,
    required this.gridIndex,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProductById(productid));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<ProductBloc>().add(FetchProducts());
              CustomNavigator.goBack(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text(
          "Product",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              productDeletemsd(context, productid);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductOperationSuccess) {
            context.read<ProductBloc>().add(FetchProductById(productid));
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is SingleProductLoaded) {
              return _buildProductDetails(context, state.product);
            } else if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text("not mentioned state the state is : $state"),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailedHeader(images: product.pictures),
                  ProductDetailedDetails(productModel: product),
                  const SizedBox(height: 16),
                  ProductReviews(reviews: [
                    ReviewModel(
                      userId: "Sulaiman",
                      comment: "This is an awesome product!",
                      rating: 5,
                    ),
                    ReviewModel(
                      userId: "Sahal",
                      comment: "This product is good.",
                      rating: 3,
                    ),
                    ReviewModel(
                      userId: "Nihal",
                      comment: "This product is too bad.",
                      rating: 1,
                    ),
                  ]),
                ],
              ),
            ),
          ),
          ProductDetailFooter(productModel: product),
        ],
      ),
    );
  }
}
