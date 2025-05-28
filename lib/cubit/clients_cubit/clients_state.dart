part of 'clients_cubit.dart';

@immutable
sealed class ClientsState {}

final class ClientsInitial extends ClientsState {}

class AddClientLoadingState extends ClientsState {}

class AddClientSuccessState extends ClientsState {}

class AddClientErrorState extends ClientsState {
  final String error;
  AddClientErrorState({required this.error});
}

class GetClientLoadingState extends ClientsState {}

class GetClientSuccessState extends ClientsState {
  final List<Data> clientModel;

  GetClientSuccessState({required this.clientModel});
}

class GetClientErrorState extends ClientsState {
  final String error;
  GetClientErrorState({required this.error});
}
