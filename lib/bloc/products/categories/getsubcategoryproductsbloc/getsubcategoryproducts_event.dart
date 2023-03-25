part of 'getsubcategoryproducts_bloc.dart';

@immutable
abstract class GetsubcategoryproductsEvent {}

class GetsubcategoryproductDataEvent extends GetsubcategoryproductsEvent {
  final int id;
  GetsubcategoryproductDataEvent({required this.id});
}
