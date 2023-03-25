part of 'searchlist_bloc.dart';

@immutable
abstract class SearchlistState {}

class SearchlistInitial extends SearchlistState {}

class SearchListFailed extends SearchlistState {
  final String errorMessage;
  SearchListFailed({required this.errorMessage});
}

class SearchListSuccess extends SearchlistState {
  final List searchData;
  SearchListSuccess({required this.searchData});
}

class SearchListWaiting extends SearchlistState {}
