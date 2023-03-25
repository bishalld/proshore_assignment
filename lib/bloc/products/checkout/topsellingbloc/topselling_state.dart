part of 'topselling_bloc.dart';

@immutable
abstract class TopsellingState {}

class TopsellingInitial extends TopsellingState {}

class TopsellingError extends TopsellingState {
  final String errorMessage;

  TopsellingError({
    required this.errorMessage,
  });
}

class TopsellingWaiting extends TopsellingState {}

class TopsellingSuccess extends TopsellingState {
  List data;
  TopsellingSuccess({required this.data});
}

class SingleProductSuccess extends TopsellingState {
  var singleData;
  List relatedproducts;
  SingleProductSuccess(
      {required this.singleData, required this.relatedproducts});
}
