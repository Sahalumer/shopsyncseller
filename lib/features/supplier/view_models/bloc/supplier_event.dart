part of 'supplier_bloc.dart';

sealed class SupplierEvent extends Equatable {
  const SupplierEvent();

  @override
  List<Object> get props => [];
}

class FetchSuppliers extends SupplierEvent {}

class FetchSingleSuppliersById extends SupplierEvent {
  final String supplierId;
  const FetchSingleSuppliersById(this.supplierId);

  @override
  List<Object> get props => [supplierId];
}

class UpdateSupplier extends SupplierEvent {
  final SupplierModel supplier;
  const UpdateSupplier(this.supplier);

  @override
  List<Object> get props => [supplier];
}

class AddSupplier extends SupplierEvent {
  final SupplierModel supplier;
  const AddSupplier(this.supplier);

  @override
  List<Object> get props => [supplier];
}

class DeleteSupplier extends SupplierEvent {
  final String supplierId;
  const DeleteSupplier(this.supplierId);

  @override
  List<Object> get props => [supplierId];
}

class SearchSuppliers extends SupplierEvent {
  final String query;
  const SearchSuppliers(this.query);

  @override
  List<Object> get props => [query];
}

class SearchSupplierByProductId extends SupplierEvent {
  final String productId;

  const SearchSupplierByProductId(this.productId);

  @override
  List<Object> get props => [productId];
}
