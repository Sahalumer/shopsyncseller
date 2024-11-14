part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class EmptyProduct extends ProductState {}

class ProductOperationSuccess extends ProductState {}

class ProductError extends ProductState {
  final String msg;
  const ProductError(this.msg);

  @override
  List<Object> get props => [msg];
}

class ProductAddedSuccessfully extends ProductState {
  final String productId;
  const ProductAddedSuccessfully(this.productId);

  @override
  List<Object> get props => [productId];
}

class SingleProductLoaded extends ProductState {
  final ProductModel product;
  const SingleProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}
