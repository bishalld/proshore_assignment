part of 'brandproduct_bloc.dart';

@immutable
abstract class BrandproductState {}

class BrandproductInitial extends BrandproductState {}

class BrandproductError extends BrandproductState {
  final String errorMessage;

  BrandproductError({
    required this.errorMessage,
  });
}

class BrandproductWaiting extends BrandproductState {}

class BrandProductSuccess extends BrandproductState {
  List data;
  BrandProductSuccess({required this.data});
}
