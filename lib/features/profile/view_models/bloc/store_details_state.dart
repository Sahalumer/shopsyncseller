part of 'store_details_bloc.dart';

abstract class StoreDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoreDetailsInitial extends StoreDetailsState {}

class StoreDetailsLoading extends StoreDetailsState {}

class StoreDetailsLoaded extends StoreDetailsState {
  final StoreDetailsModel storeDetails;

  StoreDetailsLoaded(this.storeDetails);

  @override
  List<Object?> get props => [storeDetails];
}

class StoreDetailsEmpty extends StoreDetailsState {}

class StoreDetailsError extends StoreDetailsState {
  final String error;

  StoreDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}
