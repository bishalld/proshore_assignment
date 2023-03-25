part of 'gmailregister_bloc.dart';

@immutable
abstract class GmailregisterEvent {}

class PostGmail extends GmailregisterEvent {
  final String googleId;
  final String email;
  final String name;
  final String avatar;
  final String service;
  PostGmail(
      {required this.googleId,
      required this.name,
      required this.email,
      required this.avatar,
      required this.service});
}
