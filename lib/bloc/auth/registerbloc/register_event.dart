part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class PostRegisterDataEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String contact;
  final String address;
  PostRegisterDataEvent(
      {required this.password,
      required this.name,
      required this.email,
      required this.contact,
      required this.address});
}
