import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsyncseller/features/auth/model/user_model.dart';
import 'package:shopsyncseller/features/auth/services/firebase_auth_services.dart';
import 'package:shopsyncseller/features/auth/services/shared_preferences_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final SharedPrefService _sharedPrefService;

  AuthBloc(this._authService, this._sharedPrefService) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signUpUser(event.userModel, event.password);
        await _sharedPrefService.saveUid(event.userModel.uid!);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        UserModel? userModel =
            await _authService.loginUser(event.email, event.password);
        if (userModel != null) {
          await _sharedPrefService.saveUid(userModel.uid!);
          emit(AuthSuccess());
        } else {
          emit(const AuthError("user-not-found"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.resetPassword(event.email);
        emit(PasswordResetSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.loggingOut();
        await _sharedPrefService.logOut();
        emit(LogoutSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<FetchUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        UserModel userModel = await _authService.fetchUser();
        emit(FetchSuccess(userModel));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
