part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class InitialRegisterstState extends RegisterState {}

class RegisterError extends RegisterState {
  final String errorMessage;
  final String emailErrorMsg;
  final String contactErrorMsg;

  RegisterError(
      {required this.errorMessage,
      this.emailErrorMsg = "",
      this.contactErrorMsg = ""});
}

class RegisterWaiting extends RegisterState {}

class RegisterSuccess extends RegisterState {
  String message;
  String token;
  RegisterSuccess({required this.message, required this.token});
}
