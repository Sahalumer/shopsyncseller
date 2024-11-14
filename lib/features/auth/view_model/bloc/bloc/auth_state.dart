part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

class PasswordResetSuccess extends AuthState {}

class LogoutSuccess extends AuthState {}

class FetchSuccess extends AuthState {
  final UserModel userModel;
  const FetchSuccess(this.userModel);
}