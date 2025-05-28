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
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? description;
  postClint() async {
    try {
      emit(AddClientLoadingState());
      await api.post(
          url: clientEndPoint,
          data: {
            'name': name,
            'email': email,
            'phone': phone,
            'address': address,
            'description': description,
          },
          isFormData: true);
      emit(AddClientSuccessState());
    } catch (e) {
      emit(AddClientErrorState(error: e.toString()));
    }
  }

  getClint() async {
    try {
      emit(GetClientLoadingState());

      var response = await api.get(
        url: clientEndPoint,
      );
      ClientModel clientModel = ClientModel.fromJson(response);
      List<Data> clients = clientModel.data ?? [];
      emit(GetClientSuccessState(clientModel: clients));
    } catch (e) {
      emit(GetClientErrorState(error: e.toString()));
    }
  }
}
