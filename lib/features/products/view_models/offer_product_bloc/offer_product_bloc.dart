import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopsyncseller/features/products/models/offer_model.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/services/product_firebase_services.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

part 'offer_product_event.dart';
part 'offer_product_state.dart';

class OfferProductBloc extends Bloc<OfferProductEvent, OfferProductState> {
  final productService = ProductFirebaseServices();

  OfferProductBloc() : super(OfferProductInitial()) {
    on<FetchOfferProducts>((event, emit) async {
      emit(OfferProductLoading());
      print("fetchProductcalled");
      try {
        final productStream = productService.fetchOfferProducts(globalUid!);
        await emit.forEach<List<OfferProductModel>>(
          productStream,
          onData: (products) => products.isEmpty
              ? EmptyOfferProduct()
              : OfferProductLoaded(products),
          onError: (error, stackTrace) => OfferProductError(error.toString()),
        );
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });

    on<UpdateOffer>((event, emit) async {
      emit(OfferProductLoading());
      try {
        print("Update offer called");
        await productService.updateOffer(
            globalUid!, event.productId, event.offer);
        emit(OfferProductOperationSuccess());
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });

    on<UpdateOfferProduct>((event, emit) async {
      emit(OfferProductLoading());
      try {
        print("Update offer called");
        await productService.updateOfferProduct(globalUid!, event.product);
        emit(OfferProductOperationSuccess());
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });

    on<AddOffer>((event, emit) async {
      emit(OfferProductLoading());
      try {
        print("Add offer called");
        final productId = await productService.addOffer(
            globalUid!, event.product, event.offer);
        if (productId != null) {
          FetchOfferProducts();
        }
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });

    on<RemoveOffer>((event, emit) async {
      emit(OfferProductLoading());
      try {
        print("Remove offer called");
        await productService.removeOffer(globalUid!, event.productId);
        emit(OfferProductOperationSuccess());
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });

    on<FetchOfferProductById>((event, emit) async {
      emit(OfferProductLoading());
      try {
        final OfferProductModel? product = await productService
            .fetchOfferProductById(globalUid!, event.productId);
        if (product != null) {
          emit(SingleOfferProductLoaded(product));
        }
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });
    on<DeleteOfferProduct>((event, emit) async {
      emit(OfferProductLoading());
      try {
        print("delete offer product called");
        await productService.deleteOfferProduct(globalUid!, event.productId);
        emit(OfferProductOperationSuccess());
      } catch (e) {
        emit(OfferProductError(e.toString()));
      }
    });
  }
}
