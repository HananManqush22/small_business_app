import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/core/api/api_consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/models/out_cost_model.dart';

part 'project_expenses_state.dart';

class ProjectExpensesCubit extends Cubit<ProjectExpensesState> {
  ProjectExpensesCubit(this.api) : super(ProjectExpensesInitial());
  final ApiConsumer api;
  static ProjectExpensesCubit get(context) => BlocProvider.of(context);
  List<Data> outCos = [];
  getOutCost(projectId) async {
    try {
      emit(GitOutCostLoadingState());
      var response = await api
          .get(url: outCostEndPoint, query: {"WithProjectID": projectId});
      OutCostModel outCostModel = OutCostModel.fromJson(response);
      outCos = outCostModel.data ?? [];
      emit(GitOutCostSuccessState());
    } catch (e) {
      emit(GitOutCostErrorState(error: e.toString()));
    }
  }

  postOutCost(
      {required String? projectId,
      required String? amount,
      required String? description}) async {
    try {
      emit(PostOutCostLoadingState());

      await api.post(url: outCostEndPoint, data: {
        'projectID': projectId,
        'amount': amount,
        'description': description,
      });

      // print(outCos.length);
      // print('..............................');
      // OutCostModel outCostModel = OutCostModel.fromJson(response);
      // Data newOutCos = outCostModel.data as Data;
      // outCos.add(newOutCos);
      // print(outCos.length);
      emit(PostCostSuccessState());
    } catch (e) {
      emit(PostCostErrorState(error: e.toString()));
    }
  }
}
