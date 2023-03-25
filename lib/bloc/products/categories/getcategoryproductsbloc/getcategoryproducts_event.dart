part of 'getcategoryproducts_bloc.dart';

@immutable
abstract class GetcategoryproductsEvent {}

class GetSubcategoryProductsDataEvent extends GetcategoryproductsEvent {
  final int id;
  GetSubcategoryProductsDataEvent({required this.id});
}
