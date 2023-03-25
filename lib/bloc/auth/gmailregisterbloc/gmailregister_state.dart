part of 'gmailregister_bloc.dart';

@immutable
abstract class GmailregisterState {}

class GmailregisterInitial extends GmailregisterState {}

class GmailRegisterError extends GmailregisterState {
  final String errorMessage;
  GmailRegisterError({required this.errorMessage});
}

class GmailRegisterWaiting extends GmailregisterState {}

class GmailRegisterSuccess extends GmailregisterState {
  final String message;
  final String token;
  final String status;
  final String fileName;
  final bool success;

  GmailRegisterSuccess(
      {required this.message,
      required this.token,
      required this.status,
      required this.fileName,
      required this.success});
}
