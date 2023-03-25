part of 'tagproduct_bloc.dart';

@immutable
abstract class TagproductEvent {}

class TagproductDataEvent extends TagproductEvent {
  final int id;
  TagproductDataEvent({required this.id});
}
