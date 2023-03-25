part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class InitialSigninstState extends SigninState {}

class SigninError extends SigninState {
  final String errorMessage;

  SigninError({
    required this.errorMessage,
  });
}

class SignInWaiting extends SigninState {}

class SignInSuccess extends SigninState {
  String message;
  String token;
  SignInSuccess({required this.message, required this.token});
}
