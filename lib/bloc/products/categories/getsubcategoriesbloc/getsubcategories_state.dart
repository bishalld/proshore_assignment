part of 'getsubcategories_bloc.dart';

abstract class GetsubcategoriesState {}

class GetsubcategoriesInitial extends GetsubcategoriesState {}

class GetsubcategoriesError extends GetsubcategoriesState {
  final String errorMessage;

  GetsubcategoriesError({
    required this.errorMessage,
  });
}

class GetsubcategoriesWaiting extends GetsubcategoriesState {}

class GetsubcategoriesSuccess extends GetsubcategoriesState {
  List data;
  GetsubcategoriesSuccess({required this.data});
}
