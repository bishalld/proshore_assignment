part of 'forgot_pwd_bloc.dart';

@immutable
abstract class ForgotPwdEvent {}

class PostEmailEvent extends ForgotPwdEvent {
  final String email;
  PostEmailEvent({required this.email});
}
