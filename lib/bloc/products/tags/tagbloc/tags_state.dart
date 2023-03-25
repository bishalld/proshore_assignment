part of 'tags_bloc.dart';

@immutable
abstract class TagsState {}

class TagsInitial extends TagsState {}

class TagsError extends TagsState {
  final String errorMessage;

  TagsError({
    required this.errorMessage,
  });
}

class TagsWaiting extends TagsState {}

class TagsSuccess extends TagsState {
  List data;
  TagsSuccess({required this.data});
}
