part of 'sing_in_cubit.dart';

@immutable
sealed class SingInState {}

final class SingInInitial extends SingInState {}

class SingInLoadingState extends SingInState {}

class SingInSuccessState extends SingInState {}

class SingInErrorState extends SingInState {
  final String error;
  SingInErrorState({required this.error});
}

class SingInGooglLoadingState extends SingInState {}

class SingInGooglSuccessState extends SingInState {}

class SingInGooglErrorState extends SingInState {
  final String error;
  SingInGooglErrorState({required this.error});
}
