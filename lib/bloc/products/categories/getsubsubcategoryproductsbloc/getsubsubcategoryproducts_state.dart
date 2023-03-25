part of 'getsubsubcategoryproducts_bloc.dart';

@immutable
abstract class GetsubsubcategoryproductsState {}

class GetsubsubcategoryproductsInitial extends GetsubsubcategoryproductsState {}

class GetsubsubcategoryproductsError extends GetsubsubcategoryproductsState {
  final String errorMessage;

  GetsubsubcategoryproductsError({
    required this.errorMessage,
  });
}

class GetsubsubcategoryproductsWaiting extends GetsubsubcategoryproductsState {}

class GetsubsubcategoryproductsSuccess extends GetsubsubcategoryproductsState {
  List data;
  GetsubsubcategoryproductsSuccess({required this.data});
}
