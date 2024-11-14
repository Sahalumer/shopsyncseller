part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel product;
  const AddProduct(this.product);
  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final String productId;
  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateProduct extends ProductEvent {
  final ProductModel product;
  const UpdateProduct(this.product);
  @override
  List<Object> get props => [product];
}

class FetchProductById extends ProductEvent {
  final String productId;
  const FetchProductById(this.productId);

  @override
  List<Object> get props => [productId];
}
