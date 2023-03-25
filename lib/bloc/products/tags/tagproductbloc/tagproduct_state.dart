part of 'tagproduct_bloc.dart';

@immutable
abstract class TagproductState {}

class TagproductInitial extends TagproductState {}

class TagproductError extends TagproductState {
  final String errorMessage;

  TagproductError({
    required this.errorMessage,
  });
}

class TagproductWaiting extends TagproductState {}

class TagproductSuccess extends TagproductState {
  List data;
  TagproductSuccess({required this.data});
}
