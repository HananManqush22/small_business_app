part of 'project_cubit.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

class PostProjectLoadingState extends ProjectState {}

class PostProjectSuccessState extends ProjectState {}

class PostProjectErrorState extends ProjectState {
  final String error;
  PostProjectErrorState({required this.error});
}

class GetProjectLoadingState extends ProjectState {}

class GetProjectSuccessState extends ProjectState {}

class GetProjectErrorState extends ProjectState {
  final String error;
  GetProjectErrorState({required this.error});
}

class GetIdeClientSuccessState extends ProjectState {}

class GetReminderDateSuccessState extends ProjectState {}

class GetChangeStatusSuccessState extends ProjectState {}
