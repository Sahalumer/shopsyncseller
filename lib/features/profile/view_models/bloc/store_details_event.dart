part of 'store_details_bloc.dart';

abstract class StoreDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchStoreDetailsEvent extends StoreDetailsEvent {
  final String uid;

  FetchStoreDetailsEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class AddOrUpdateStoreEvent extends StoreDetailsEvent {
  final StoreDetailsModel storeDetails;
  final String uid;

  AddOrUpdateStoreEvent(this.storeDetails, this.uid);

  @override
  List<Object?> get props => [storeDetails, uid];
}
