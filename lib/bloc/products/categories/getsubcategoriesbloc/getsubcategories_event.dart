part of 'getsubcategories_bloc.dart';

abstract class GetsubcategoriesEvent {}

class GetSubcategoriesDataEvent extends GetsubcategoriesEvent {
  final int id;
  GetSubcategoriesDataEvent({required this.id});
}
