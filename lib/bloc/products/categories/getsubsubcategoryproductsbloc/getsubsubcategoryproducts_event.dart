part of 'getsubsubcategoryproducts_bloc.dart';

@immutable
abstract class GetsubsubcategoryproductsEvent {}

class GetSubcategoryProductsDataEvent extends GetsubsubcategoryproductsEvent {
  final int id;
  GetSubcategoryProductsDataEvent({required this.id});
}
