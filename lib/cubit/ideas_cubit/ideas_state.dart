part of 'ideas_cubit.dart';

@immutable
sealed class IdeasState {}

final class IdeasInitial extends IdeasState {}

class PostIdeaStateLoadingState extends IdeasState {}

class PostIdeaSuccessState extends IdeasState {}

class PostIdeaErrorState extends IdeasState {
  final String error;
  PostIdeaErrorState({required this.error});
}

class GetIdeaStateLoadingState extends IdeasState {}

class GetIdeaSuccessState extends IdeasState {}

class GetIdeaErrorState extends IdeasState {
  final String error;
  GetIdeaErrorState({required this.error});
}
