part of 'fetchcategories_bloc.dart';

@immutable
abstract class FetchcategoriesState {}

class FetchcategoriesInitial extends FetchcategoriesState {}

class InitialFetchcategoriesstState extends FetchcategoriesState {}

class FetchcategoriesError extends FetchcategoriesState {
  final String errorMessage;

  FetchcategoriesError({
    required this.errorMessage,
  });
}

class FetchcategoriesWaiting extends FetchcategoriesState {}

class FetchcategoriesSuccess extends FetchcategoriesState {
  List data;
  FetchcategoriesSuccess({required this.data});
}
