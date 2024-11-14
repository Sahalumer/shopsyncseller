import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/models/review_model.dart';
import 'package:shopsyncseller/features/products/view_models/offer_product_bloc/offer_product_bloc.dart';
import 'package:shopsyncseller/features/products/views/components/offer_product_detail_footer.dart';
import 'package:shopsyncseller/features/products/views/components/offer_product_details_component.dart';
import 'package:shopsyncseller/features/products/views/components/product_detailed_header.dart';
import 'package:shopsyncseller/features/products/views/components/product_reviews.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_delete_msg.dart';

class OfferProductDetailedView extends StatelessWidget {
  final String productId;
  const OfferProductDetailedView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<OfferProductBloc>().add(FetchOfferProductById(productId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<OfferProductBloc>().add(FetchOfferProducts());
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Product"),
        actions: [
          IconButton(
            onPressed: () {
              offerProductDeletemsd(context, productId);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<OfferProductBloc, OfferProductState>(
        builder: (context, state) {
          if (state is SingleOfferProductLoaded) {
            return _buildProductDetails(context, state.product);
          } else if (state is OfferProductLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text("not mentioned state the state is : $state"),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, OfferProductModel product) {
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
                  OfferProductDetailsComponent(productModel: product),
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
          OfferProductDetailFooter(productModel: product),
        ],
      ),
    );
  }
}
