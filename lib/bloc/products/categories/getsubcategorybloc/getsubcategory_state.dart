part of 'getsubcategory_bloc.dart';

@immutable
abstract class GetsubcategoryState {}

class GetsubcategoryInitial extends GetsubcategoryState {}

class GetSubCategoryError extends GetsubcategoryState {
  final String errorMessage;

  GetSubCategoryError({
    required this.errorMessage,
  });
}

class GetSubCategoryWaiting extends GetsubcategoryState {}

class GetSubCategorySuccess extends GetsubcategoryState {
  List data;
  GetSubCategorySuccess({required this.data});
}
