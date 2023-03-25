part of 'getsubcategoryproducts_bloc.dart';

@immutable
abstract class GetsubcategoryproductsState {}

class GetsubcategoryproductsInitial extends GetsubcategoryproductsState {}

class GetsubcategoryproductsError extends GetsubcategoryproductsState {
  final String errorMessage;

  GetsubcategoryproductsError({
    required this.errorMessage,
  });
}

class GetsubcategoryproductsWaiting extends GetsubcategoryproductsState {}

class GetsubcategoryproductsSuccess extends GetsubcategoryproductsState {
  List data;
  GetsubcategoryproductsSuccess({required this.data});
}
