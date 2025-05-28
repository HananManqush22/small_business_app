import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:small_business_app/core/api/api_Consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/core/cache/cache_helper.dart';
part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this.api) : super(ProjectInitial());
  ApiConsumer api;
  static ProjectCubit get(context) => BlocProvider.of(context);
  TextEditingController date = TextEditingController();

  String? name;
  String? clientID;
  String? description;
  String status = 'قيد التنفيد';
  String? cost;
  String? reminderDate;
  String? selectedClient;
  String? selectedReminderDate;
  DateTime? pickerDate;
  String? remindDateValue;
  bool inProgress = true;
  bool waiting = false;
  bool underReview = false;

  var formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  postProject() async {
    try {
      emit(PostProjectLoadingState());

      await api.post(
          url: projectEndPoint,
          data: {
            'brandID': CacheHelper().getData(key: 'idBrand'),
            'clientID': clientID,
            'name': name,
            'description': description,
            'status': status,
            'cost': cost,
            'date': date.text,
          },
          isFormData: true);
      emit(PostProjectSuccessState());
    } catch (e) {
      emit(PostProjectErrorState(error: e.toString()));
    }
  }

  Future<void> selectDate(context) async {
    pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(200),
        lastDate: DateTime(2100));
  }

  chooseReminderDate(value, context) async {
    try {
      if (pickerDate != null) {
        if (value == 'يوم') {
          remindDateValue = value;
          var oneDate = pickerDate!.subtract(Duration(days: 1));
          selectedReminderDate = DateFormat('dd-MM-yyyy').format(oneDate);
          emit(GetReminderDateSuccessState());
        } else if (value == 'يومين') {
          remindDateValue = value;
          var twoDate = pickerDate!.subtract(Duration(days: 2));
          selectedReminderDate = DateFormat('dd-MM-yyyy').format(twoDate);
          emit(GetReminderDateSuccessState());
        } else if (value == 'اسبوع') {
          remindDateValue = value;
          var weekDate = pickerDate!.subtract(Duration(days: 7));
          selectedReminderDate = DateFormat('dd-MM-yyyy').format(weekDate);
          emit(GetReminderDateSuccessState());
        } else {
          await selectDate(context);
          selectedReminderDate = DateFormat('dd-MM-yyyy').format(pickerDate!);
          remindDateValue = 'اختار تاريخ';
          emit(GetReminderDateSuccessState());
        }
      } else {
        print('.......... اختر موعد التسليم');
      }
    } on Exception catch (e) {
      print('.................${e.toString()}');
    }
  }

  void updateClientID(String newID) {
    clientID = newID;
    emit(GetIdeClientSuccessState());
  }

  void upDateStatus() {
    if (status == 'قيد التنفيد') {
      inProgress = true;
      waiting = false;
      underReview = false;

      emit(GetChangeStatusSuccessState());
    } else if (status == 'تحت الانتظار') {
      inProgress = false;
      waiting = true;
      underReview = false;
      emit(GetChangeStatusSuccessState());
    } else {
      inProgress = false;
      waiting = false;
      underReview = true;
      emit(GetChangeStatusSuccessState());
    }
  }
}
