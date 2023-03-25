part of 'topselling_bloc.dart';

@immutable
abstract class TopsellingEvent {}

class TopsellingDataEvent extends TopsellingEvent {}

class SingleProductDataEvent extends TopsellingEvent {
  final String urlname;
  SingleProductDataEvent({required this.urlname});
}
