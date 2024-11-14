import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:shopsyncseller/features/profile/models/store_details_model.dart';
import 'package:shopsyncseller/features/profile/services/firebase_store_services.dart';

part 'store_details_event.dart';
part 'store_details_state.dart';

class StoreDetailsBloc extends Bloc<StoreDetailsEvent, StoreDetailsState> {
  StoreDetailsBloc() : super(StoreDetailsInitial()) {
    on<FetchStoreDetailsEvent>((event, emit) async {
      final FirebaseStoreDetailsServices firebaseStoreDetailsServices =
          FirebaseStoreDetailsServices();
      emit(StoreDetailsLoading());
      try {
        final storeDetails =
            await firebaseStoreDetailsServices.fetchDetails(event.uid);
        if (storeDetails != null) {
          emit(StoreDetailsLoaded(storeDetails));
        } else {
          emit(StoreDetailsEmpty());
        }
      } catch (e) {
        emit(StoreDetailsError(e.toString()));
      }
    });

    on<AddOrUpdateStoreEvent>((event, emit) async {
      final FirebaseStoreDetailsServices firebaseStoreDetailsServices =
          FirebaseStoreDetailsServices();
      emit(StoreDetailsLoading());
      try {
        await firebaseStoreDetailsServices.addorEditDetails(
            event.storeDetails, event.uid);
        emit(StoreDetailsLoaded(event.storeDetails));
      } catch (e) {
        emit(StoreDetailsError(e.toString()));
      }
    });
  }
}
