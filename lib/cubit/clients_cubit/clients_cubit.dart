import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/core/api/api_consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/models/client_model.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.api) : super(ClientsInitial());
  final ApiConsumer api;
  static ClientsCubit get(context) => BlocProvider.of(context);

  postClint(
      {required String name,
      required String email,
      required String phone,
      required String address,
      required String description}) async {
    try {
      emit(AddClientLoadingState());
      var response = await api.post(
          url: clientEndPoint,
          data: {
            'name': name,
            'email': email,
            'phone': phone,
            'address': address,
            'description': description,
          },
          isFormData: true);
      ClientData newClient = ClientData(
        address: address,
        name: name,
        email: email,
        phone: phone,
        description: description,
        id: response['idClient'],
      );
      clients.add(newClient);
      emit(AddClientSuccessState());
    } catch (e) {
      emit(AddClientErrorState(error: e.toString()));
    }
  }

  List<ClientData> clients = [];
  getClint() async {
    try {
      if (clients.isNotEmpty) {
        emit(GetClientSuccessState(clientModel: clients));
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(GetClientLoadingState());

        var response = await api.get(
          url: clientEndPoint,
        );
        ClientModel clientModel = ClientModel.fromJson(response);
        clients = clientModel.data ?? [];
        emit(GetClientSuccessState(clientModel: clients));
      }
    } catch (e) {
      emit(GetClientErrorState(error: e.toString()));
    }
  }

  getClintById(int? id) {
    if (clients.isNotEmpty) {
      return clients.where((value) => value.id == id).toList();
    }
  }
}
