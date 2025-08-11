part of 'create_user_cubit.dart';

@immutable
sealed class CreateUserState {}

final class CreateUserInitial extends CreateUserState {}

class SingInLoadingState extends CreateUserState {}

class SingInSuccessState extends CreateUserState {}

class SingInErrorState extends CreateUserState {
  final String error;
  SingInErrorState({required this.error});
}

class SingInGooglLoadingState extends CreateUserState {}

class SingInGooglSuccessState extends CreateUserState {}

class SingInGooglErrorState extends CreateUserState {
  final String error;
  SingInGooglErrorState({required this.error});
}

class UserCreateLoadingState extends CreateUserState {}

class UserCreateSuccessState extends CreateUserState {}

class UserCreateErrorState extends CreateUserState {
  final String error;
  UserCreateErrorState({required this.error});
}
