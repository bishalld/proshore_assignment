part of 'forgot_pwd_bloc.dart';

@immutable
abstract class ForgotPwdState {}

class ForgotPwdInitial extends ForgotPwdState {}

class ForgotPwdError extends ForgotPwdState {
  final String errorMessage;
  ForgotPwdError({required this.errorMessage});
}

class ForgotPwdWaiting extends ForgotPwdState {}

class ForgotPwdSuccess extends ForgotPwdState {
  final String successMsg;
  ForgotPwdSuccess({required this.successMsg});
}
