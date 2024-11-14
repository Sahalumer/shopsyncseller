part of 'supplier_bloc.dart';

sealed class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object> get props => [];
}

final class SupplierInitial extends SupplierState {}

final class SupplierLoading extends SupplierState {}

final class SuppliersLoaded extends SupplierState {
  final List<SupplierModel> suppliers;
  const SuppliersLoaded(this.suppliers);

  @override
  List<Object> get props => [suppliers];
}

final class SingleSupplierLoaded extends SupplierState {
  final SupplierModel supplier;
  const SingleSupplierLoaded(this.supplier);

  @override
  List<Object> get props => [supplier];
}

final class SupplierOperationSuccess extends SupplierState {}

final class SupplierError extends SupplierState {
  final String msg;
  const SupplierError(this.msg);

  @override
  List<Object> get props => [msg];
}

final class EmptySupplier extends SupplierState {}

final class SupplierFound extends SupplierState {
  final SupplierModel supplier;
  const SupplierFound(this.supplier);

  @override
  List<Object> get props => [supplier];
}

final class SupplierNotFound extends SupplierState {}
