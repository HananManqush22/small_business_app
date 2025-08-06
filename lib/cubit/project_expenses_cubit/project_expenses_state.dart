part of 'project_expenses_cubit.dart';

@immutable
sealed class ProjectExpensesState {}

final class ProjectExpensesInitial extends ProjectExpensesState {}

class GitOutCostLoadingState extends ProjectExpensesState {}

class GitOutCostSuccessState extends ProjectExpensesState {}

class GitOutCostErrorState extends ProjectExpensesState {
  final String error;
  GitOutCostErrorState({required this.error});
}

class PostOutCostLoadingState extends ProjectExpensesState {}

class PostCostSuccessState extends ProjectExpensesState {}

class PostCostErrorState extends ProjectExpensesState {
  final String error;
  PostCostErrorState({required this.error});
}
