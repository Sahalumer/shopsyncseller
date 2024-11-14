part of 'offer_product_bloc.dart';

sealed class OfferProductEvent extends Equatable {
  const OfferProductEvent();

  @override
  List<Object> get props => [];
}

class FetchOfferProducts extends OfferProductEvent {}

class FetchOfferProductById extends OfferProductEvent {
  final String productId;
  const FetchOfferProductById(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateOffer extends OfferProductEvent {
  final String productId;
  final Offer offer;
  const UpdateOffer(this.productId, this.offer);

  @override
  List<Object> get props => [productId, offer];
}

class UpdateOfferProduct extends OfferProductEvent {
  final OfferProductModel product;
  const UpdateOfferProduct(
    this.product,
  );

  @override
  List<Object> get props => [product];
}

class AddOffer extends OfferProductEvent {
  final ProductModel product;
  final Offer offer;
  const AddOffer(this.offer, this.product);

  @override
  List<Object> get props => [product, offer];
}

class RemoveOffer extends OfferProductEvent {
  final String productId;
  const RemoveOffer(this.productId);

  @override
  List<Object> get props => [productId];
}

class DeleteOfferProduct extends OfferProductEvent {
  final String productId;
  const DeleteOfferProduct(this.productId);

  @override
  List<Object> get props => [productId];
}
