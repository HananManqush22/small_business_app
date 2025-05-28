part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class UploadProfilePicSuccessState extends ProfileState {}

class PostProfileStateLoadingState extends ProfileState {}

class PostProfileSuccessState extends ProfileState {}

class PostProfileErrorState extends ProfileState {
  final String error;
  PostProfileErrorState({required this.error});
}

class GetProfileStateLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final List<Data> profiledModel;

  GetProfileSuccessState({required this.profiledModel});
}

class GetProfileErrorState extends ProfileState {
  final String error;
  GetProfileErrorState({required this.error});
}
