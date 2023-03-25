part of 'homebanner_bloc.dart';

@immutable
abstract class HomebannerState {}

class BannerInitial extends HomebannerState {}

class BannerSuccess extends HomebannerState {
  final List data;
  BannerSuccess({required this.data});
}

class BannerWaiting extends HomebannerState {}

class BannerError extends HomebannerState {
  final errorMessage;
  BannerError({required this.errorMessage});
}
