import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/core/api/api_consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/models/ideas_model.dart';

part 'ideas_state.dart';

class IdeasCubit extends Cubit<IdeasState> {
  IdeasCubit(this.api) : super(IdeasInitial());
  final ApiConsumer api;

  List<IdeasData> ideasList = [];
  static IdeasCubit get(context) => BlocProvider.of(context);
  postIdea({required String title, required String description}) async {
    try {
      emit(PostIdeaStateLoadingState());
      await api.post(url: ideaEndPoint, data: {
        'title': title,
        'description': description,
        'status': 'undone'
      });
      IdeasData ideasData = IdeasData(
        title: title,
        description: description,
        status: 'undone',
      );
      ideasList.add(ideasData);

      emit(PostIdeaSuccessState());
    } catch (e) {
      emit(PostIdeaErrorState(error: e.toString()));
    }
  }

  getIdeas() async {
    try {
      emit(GetIdeaStateLoadingState());
      var response = await api.get(
        url: ideaEndPoint,
      );
      IdeasModel ideasModel = IdeasModel.fromJson(response);
      ideasList = ideasModel.data ?? [];

      emit(GetIdeaSuccessState());
    } catch (e) {
      emit(GetIdeaErrorState(error: e.toString()));
    }
  }
}
