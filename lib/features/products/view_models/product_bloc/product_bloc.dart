import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/products/services/product_firebase_services.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final productService = ProductFirebaseServices();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        print("Normal FetchProduct called");
        final productStream = productService.fetchProducts(globalUid!);
        await emit.forEach<List<ProductModel>>(
          productStream,
          onData: (products) =>
              products.isEmpty ? EmptyProduct() : ProductsLoaded(products),
          onError: (error, stackTrace) => ProductError(error.toString()),
        );
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final productId =
            await productService.addProduct(globalUid!, event.product);
        if (productId != null) {
          emit(ProductAddedSuccessfully(productId));
          add(FetchProducts());
        } else {
          emit(ProductError("Failed to add product"));
        }
      } catch (e) {
        emit(ProductError("Error adding product: $e"));
      }
    });

    on<UpdateProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        print("normal update product called");
        await productService.updateProduct(globalUid!, event.product);
        emit(ProductOperationSuccess());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<DeleteProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        print("Normal delete product called");
        await productService.deleteProduct(globalUid!, event.productId);
        FetchProducts();
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<FetchProductById>((event, emit) async {
      emit(ProductLoading());
      try {
        print("Normal FetchProduct by id called");
        final ProductModel? product =
            await productService.fetchProductById(globalUid!, event.productId);
        if (product != null) {
          emit(SingleProductLoaded(product));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
