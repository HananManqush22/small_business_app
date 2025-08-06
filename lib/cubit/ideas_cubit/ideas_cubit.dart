import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_business_app/core/api/api_consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';

part 'ideas_state.dart';

class IdeasCubit extends Cubit<IdeasState> {
  IdeasCubit(this.api) : super(IdeasInitial());
  final ApiConsumer api;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  static IdeasCubit get(context) => BlocProvider.of(context);
  postIdea() async {
    try {
      emit(PostIdeaStateLoadingState());
      await api.post(url: ideaEndPoint, data: {
        'title': title.text,
        'description': description.text,
        'status': 'false'
      });
      emit(PostIdeaSuccessState());
    } catch (e) {
      emit(PostIdeaErrorState(error: e.toString()));
    }
  }

  getIdeas() async {
    try {
      emit(GetIdeaStateLoadingState());
      await api.get(
        url: ideaEndPoint,
      );

      emit(GetIdeaSuccessState());
    } catch (e) {
      emit(GetIdeaErrorState(error: e.toString()));
    }
  }
}
