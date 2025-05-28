part of 'fire_authentication_cubit.dart';

@immutable
sealed class FireAuthenticationState {}

final class FireAuthenticationInitial extends FireAuthenticationState {}

class SingInLoadingState extends FireAuthenticationState {}

class SingInSuccessState extends FireAuthenticationState {}

class SingInErrorState extends FireAuthenticationState {
  final String error;
  SingInErrorState({required this.error});
}

class SingInGooglLoadingState extends FireAuthenticationState {}

class SingInGooglSuccessState extends FireAuthenticationState {}

class SingInGooglErrorState extends FireAuthenticationState {
  final String error;
  SingInGooglErrorState({required this.error});
}

class UserCreateLoadingState extends FireAuthenticationState {}

class UserCreateSuccessState extends FireAuthenticationState {}

class UserCreateErrorState extends FireAuthenticationState {
  final String error;
  UserCreateErrorState({required this.error});
}
