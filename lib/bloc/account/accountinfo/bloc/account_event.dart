part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class AccountInfoEvent extends AccountEvent {}

////update profile

class AccountUpdateEvent extends AccountEvent {
  final String name;
  final String contact;
  final String email;
  final String imageUrl;

  AccountUpdateEvent({
    required this.name,
    required this.email,
    required this.contact,
    required this.imageUrl,
  });
}
