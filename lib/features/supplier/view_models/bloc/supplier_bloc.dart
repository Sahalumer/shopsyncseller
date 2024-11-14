import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopsyncseller/features/products/services/product_firebase_services.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/features/supplier/services/suppllier_firebase_services.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final supplierService = SupplierFirebaseServices();

  SupplierBloc() : super(SupplierInitial()) {
    on<FetchSuppliers>((event, emit) async {
      emit(SupplierLoading());
      try {
        final supplierStream = supplierService.fetchSuppliers(globalUid!);
        await emit.forEach<List<SupplierModel>>(
          supplierStream,
          onData: (suppliers) =>
              suppliers.isEmpty ? EmptySupplier() : SuppliersLoaded(suppliers),
          onError: (error, stackTrace) => SupplierError(error.toString()),
        );
      } catch (e) {
        emit(SupplierError(e.toString()));
      }
    });

    on<FetchSingleSuppliersById>((event, emit) async {
      emit(SupplierLoading());
      try {
        final supplier = await supplierService.fetchSingleSupplierById(
            globalUid!, event.supplierId);
        if (supplier != null) {
          emit(SingleSupplierLoaded(supplier));
        } else {
          emit(SupplierError("Supplier not found"));
        }
      } catch (e) {
        emit(SupplierError(e.toString()));
      }
    });

    on<AddSupplier>((event, emit) async {
      emit(SupplierLoading());
      try {
        final supplierId =
            await supplierService.addSupplier(globalUid!, event.supplier);
        if (supplierId != null) {
          add(FetchSuppliers()); // Fetch suppliers after adding
          emit(SupplierOperationSuccess());
        } else {
          emit(SupplierError("Failed to add supplier"));
        }
      } catch (e) {
        emit(SupplierError(e.toString()));
      }
    });

    on<UpdateSupplier>((event, emit) async {
      emit(SupplierLoading());
      try {
        await supplierService.updateSupplier(globalUid!, event.supplier);
        emit(SupplierOperationSuccess());
        add(FetchSuppliers());
      } catch (e) {
        emit(SupplierError(e.toString()));
      }
    });

    on<DeleteSupplier>((event, emit) async {
      emit(SupplierLoading());
      try {
        await supplierService.deleteSupplier(globalUid!, event.supplierId);
        add(FetchSuppliers());
        emit(SupplierOperationSuccess());
      } catch (e) {
        emit(SupplierError(e.toString()));
      }
    });
    on<SearchSuppliers>((event, emit) async {
      emit(SupplierLoading());
      try {
        final suppliers =
            await supplierService.searchSuppliers(globalUid!, event.query);
        if (suppliers.isEmpty) {
          emit(EmptySupplier());
        } else {
          emit(SuppliersLoaded(suppliers));
        }
      } catch (e) {
        emit(SupplierError(e.toString()));
      }
    });
    on<SearchSupplierByProductId>((event, emit) async {
      emit(SupplierLoading());
      try {
        print(event.productId);
        final supplier = await ProductFirebaseServices()
            .searchForSupplier(globalUid!, event.productId);

        if (supplier != null) {
          emit(SupplierFound(supplier));
        } else {
          emit(SupplierNotFound());
        }
      } catch (e) {
        emit(SupplierError("Error searching for supplier: $e"));
      }
    });
  }
}
