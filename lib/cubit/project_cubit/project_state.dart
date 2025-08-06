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

class PatchProjectLoadingState extends ProjectState {}

class PatchProjectSuccessState extends ProjectState {}

class PatchProjectErrorState extends ProjectState {
  final String error;
  PatchProjectErrorState({required this.error});
}

class GitProjectLoadingState extends ProjectState {}

class GitProjectSuccessState extends ProjectState {}

class GitProjectErrorState extends ProjectState {
  final String error;
  GitProjectErrorState({required this.error});
}

class GetProjectLoadingState extends ProjectState {}

class GetProjectSuccessState extends ProjectState {
  final List<Data> projectModel;
  GetProjectSuccessState({required this.projectModel});
}

class GetProjectErrorState extends ProjectState {
  final String error;
  GetProjectErrorState({required this.error});
}

class GetIdeClientSuccessState extends ProjectState {}

class GetClientByIdSuccessState extends ProjectState {}

class GetReminderDateSuccessState extends ProjectState {}

class GetChangeStatusSuccessState extends ProjectState {}

class OutCostUpdatedState extends ProjectState {}

class PostAllOutCostLoadingState extends ProjectState {}

class PostAllOutCostSuccessState extends ProjectState {}

class PostAllOutCostErrorState extends ProjectState {
  final String error;
  PostAllOutCostErrorState({required this.error});
}

class PostAllTasksLoadingState extends ProjectState {}

class PostAllTasksCostSuccessState extends ProjectState {}

class PostAllTasksErrorState extends ProjectState {
  final String error;
  PostAllTasksErrorState({required this.error});
}

class TasksUpdatedState extends ProjectState {}

class RemoveTaskedState extends ProjectState {}

class ChangIndexState extends ProjectState {}
