part of 'getsubcategory_bloc.dart';

@immutable
abstract class GetsubcategoryEvent {}

class GetSubcategoryDataEvent extends GetsubcategoryEvent {
  final int id;
  GetSubcategoryDataEvent({required this.id});
}
