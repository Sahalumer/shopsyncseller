import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/view_models/product_bloc/product_bloc.dart';
import 'package:shopsyncseller/features/products/views/screens/product_add_edit_view.dart';
import 'package:shopsyncseller/features/products/views/widgets/product_detail_button.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class ProductDetailFooter extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailFooter({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Row(
      children: [
        Expanded(
          child: ProductDetailButton(
              onSubmit: () {
                context.read<ProductBloc>().add(FetchProducts());
                Navigator.pop(context);
              },
              text: "Back"),
        ),
        SizedBox(
          width: size.scaledWidth(1),
        ),
        Expanded(
          child: ProductDetailButton(
              onSubmit: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ProductAddEditView(
                      product: productModel,
                    ),
                  ),
                );
              },
              text: "Edit"),
        )
      ],
    );
  }
}
