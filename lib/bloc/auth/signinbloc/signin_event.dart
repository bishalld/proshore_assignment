part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class PostsignInDataEvent extends SigninEvent {
  final String phoneNumber;
  final String password;
  PostsignInDataEvent({required this.phoneNumber, required this.password});
}
