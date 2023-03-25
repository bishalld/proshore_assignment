part of 'brands_bloc.dart';

@immutable
abstract class BrandsState {}

class BrandsInitial extends BrandsState {}

class BrandsError extends BrandsState {
  final String errorMessage;

  BrandsError({
    required this.errorMessage,
  });
}

class BrandsWaiting extends BrandsState {}

class BrandsSuccess extends BrandsState {
  List data;
  BrandsSuccess({required this.data});
}
