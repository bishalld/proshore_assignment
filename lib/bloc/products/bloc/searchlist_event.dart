part of 'searchlist_bloc.dart';

@immutable
abstract class SearchlistEvent {}

class SearchProductEvent extends SearchlistEvent {
  final String productName;
  SearchProductEvent({required this.productName});
}
