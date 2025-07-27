import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/core/api/api_Consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/models/client_model.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.api) : super(ClientsInitial());
  final ApiConsumer api;
  static ClientsCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();

  postClint() async {
    try {
      emit(AddClientLoadingState());
      await api.post(
          url: clientEndPoint,
          data: {
            'name': name.text,
            'email': email.text,
            'phone': phone.text,
            'address': address.text,
            'description': description.text,
          },
          isFormData: true);

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
      emit(GetClientLoadingState());

      var response = await api.get(
        url: clientEndPoint,
      );
      ClientModel clientModel = ClientModel.fromJson(response);
      clients = clientModel.data ?? [];
      emit(GetClientSuccessState(clientModel: clients));
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
