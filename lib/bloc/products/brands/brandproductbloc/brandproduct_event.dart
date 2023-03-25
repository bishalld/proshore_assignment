part of 'brandproduct_bloc.dart';

@immutable
abstract class BrandproductEvent {}

class BrandProductDataEvent extends BrandproductEvent {
  final int id;
  BrandProductDataEvent({required this.id});
}
