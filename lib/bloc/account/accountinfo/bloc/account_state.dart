part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountFetchErrorState extends AccountState {
  final String errorMessage;
  AccountFetchErrorState({required this.errorMessage});
}

class AccountFetchSuccessState extends AccountState {
  var accountData;
  AccountFetchSuccessState({required this.accountData});
}

class AccountFetcWaiting extends AccountState {}

/////update bloc

class AccountPageState extends AccountState {}
