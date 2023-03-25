part of 'getcategoryproducts_bloc.dart';

@immutable
abstract class GetcategoryproductsState {}

class GetcategoryproductsInitial extends GetcategoryproductsState {}

class GetcategoryproductsError extends GetcategoryproductsState {
  final String errorMessage;

  GetcategoryproductsError({
    required this.errorMessage,
  });
}

class GetcategoryproductsWaiting extends GetcategoryproductsState {}

class GetcategoryproductsSuccess extends GetcategoryproductsState {
  List data;
  GetcategoryproductsSuccess({required this.data});
}
