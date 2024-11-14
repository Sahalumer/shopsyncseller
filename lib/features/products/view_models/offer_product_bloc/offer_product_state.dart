part of 'offer_product_bloc.dart';

sealed class OfferProductState extends Equatable {
  const OfferProductState();

  @override
  List<Object> get props => [];
}

class OfferProductInitial extends OfferProductState {}

class OfferProductLoading extends OfferProductState {}

class OfferProductLoaded extends OfferProductState {
  final List<OfferProductModel> products;
  const OfferProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class EmptyOfferProduct extends OfferProductState {}

class OfferProductOperationSuccess extends OfferProductState {}

class OfferProductError extends OfferProductState {
  final String msg;
  const OfferProductError(this.msg);

  @override
  List<Object> get props => [msg];
}

class SingleOfferProductLoaded extends OfferProductState {
  final OfferProductModel product;
  const SingleOfferProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}
