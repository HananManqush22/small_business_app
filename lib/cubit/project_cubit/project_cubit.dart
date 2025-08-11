import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:small_business_app/core/api/api_consumer.dart';
import 'package:small_business_app/core/api/end_point.dart';
import 'package:small_business_app/core/cache/cache_helper.dart';
import 'package:small_business_app/models/project_model.dart';
part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit(this.api) : super(ProjectInitial()) {
    initializeBrand();
  }
  ApiConsumer api;
  static ProjectCubit get(context) => BlocProvider.of(context);

  String? clientID;
  TextEditingController date = TextEditingController();
  TextEditingController outCostDescription = TextEditingController();
  TextEditingController outCostValue = TextEditingController();
  TextEditingController task = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController cost = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String status = 'قيد التنفيد';
  String changeStatus = '';

  String? reminderDate;
  String? selectedClient;
  String? selectedReminderDate;
  DateTime? pickerDate;
  String? remindDateValue;
  bool inProgress = true;
  bool waiting = false;
  bool underReview = false;
  bool done = false;
  bool cancelled = false;
  bool delivery = false;
  Map<String, String> outCost = {};
  List<String> tasks = [];

  void addOutCost(String description, String value) {
    outCost[description] = value;
    emit(OutCostUpdatedState());
  }

  void addTask(String task) {
    tasks.add(task);

    emit(TasksUpdatedState());
  }

  void removeTask(index) {
    tasks.removeAt(index);

    emit(RemoveTaskedState());
  }

  postProject() async {
    try {
      emit(PostProjectLoadingState());

      final response = await api.post(
          url: projectEndPoint,
          data: {
            'brandID': CacheHelper().getData(key: 'idBrand'),
            'clientID': clientID,
            'name': name.text,
            'description': description.text,
            'status': status,
            'cost': cost.text,
            'date': date.text,
            'dateFinish': selectedReminderDate,
          },
          isFormData: true);
      ProjectData newProject = ProjectData(
        id: response['idProject'],
        name: name.text,
        clientID: int.parse(clientID!),
        description: description.text,
        status: status,
        cost: cost.text,
        date: date.text,
        remendDate: selectedReminderDate,
      );
      projectList.add(newProject);
      if (outCost.isNotEmpty) {
        await postAllOutCost(response['idProject'].toString());
      } else if (tasks.isNotEmpty) {
        await postAllTasks(response['idProject'].toString());
      }

      emit(PostProjectSuccessState());
    } catch (e) {
      emit(PostProjectErrorState(error: e.toString()));
    }
  }

  List<ProjectData> projectList = [];
  getProject() async {
    try {
      if (projectList.isNotEmpty) {
        emit(GetProjectSuccessState(projectModel: projectList));
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(GetProjectLoadingState());
        var response = await api.get(url: projectEndPoint);
        ProjectModel projectModel = ProjectModel.fromJson(response);
        projectList = projectModel.data ?? [];
        emit(GetProjectSuccessState(projectModel: projectList));
      }
    } catch (e) {
      emit(GetProjectErrorState(error: e.toString()));
    }
  }

  patchProject(
      {required String projectId,
      required String name,
      required String date,
      required String remendDate,
      required String cost,
      required String description,
      required String status,
      required int clientId}) async {
    try {
      emit(PatchProjectLoadingState());
      var response = await api.patch(url: "$projectEndPoint/$projectId", data: {
        'name': name,
        'description': description,
        'status': status,
        'cost': cost,
        'date': date,
        'dateFinish': remendDate,
      });
      ProjectData upDateProject = ProjectData(
        id: response['idProject'],
        clientID: clientId,
        name: name,
        description: description,
        status: status,
        cost: cost,
        date: date,
        remendDate: remendDate,
      );
      int index = projectList.indexWhere((item) => item.id == upDateProject.id);
      if (index != -1) {
        projectList[index] = upDateProject;
      }
      emit(PatchProjectSuccessState());
    } catch (e) {
      emit(PatchProjectErrorState(error: e.toString()));
    }
  }

  Future<String> getClientById(String id) async {
    var response = await api.get(url: clientEndPoint, query: {'id': id});

    emit(GetClientByIdSuccessState());
    return response['name'].toString();
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
          selectedReminderDate = DateFormat('yyyy-MM-dd').format(oneDate);
          emit(GetReminderDateSuccessState());
        } else if (value == 'يومين') {
          remindDateValue = value;
          var twoDate = pickerDate!.subtract(Duration(days: 2));
          selectedReminderDate = DateFormat('yyyy-MM-dd').format(twoDate);
          emit(GetReminderDateSuccessState());
        } else if (value == 'اسبوع') {
          remindDateValue = value;
          var weekDate = pickerDate!.subtract(Duration(days: 7));
          selectedReminderDate = DateFormat('yyyy-MM-dd').format(weekDate);
          emit(GetReminderDateSuccessState());
        } else {
          await selectDate(context);
          selectedReminderDate = DateFormat('yyyy-MM-dd').format(pickerDate!);
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

  void upDateStatus(String statusValue) {
    if (statusValue == 'قيد التنفيد') {
      inProgress = true;
      waiting = false;
      underReview = false;
      done = false;
      cancelled = false;
      delivery = false;

      emit(GetChangeStatusSuccessState());
    } else if (statusValue == 'تحت الانتظار') {
      inProgress = false;
      waiting = true;
      underReview = false;
      done = false;
      cancelled = false;
      delivery = false;

      emit(GetChangeStatusSuccessState());
    } else if (statusValue == ' ثم الالغاء') {
      inProgress = false;
      waiting = false;
      underReview = false;
      done = false;
      cancelled = true;
      delivery = false;

      emit(GetChangeStatusSuccessState());
    } else if (statusValue == ' ثم التسليم') {
      inProgress = false;
      waiting = false;
      underReview = false;
      done = false;
      cancelled = false;
      delivery = true;

      emit(GetChangeStatusSuccessState());
    } else if (statusValue == 'مكتمل ') {
      inProgress = false;
      waiting = false;
      underReview = false;
      done = true;
      cancelled = false;
      delivery = false;

      emit(GetChangeStatusSuccessState());
    } else {
      inProgress = false;
      waiting = false;
      underReview = true;
      done = false;
      cancelled = false;
      delivery = false;

      emit(GetChangeStatusSuccessState());
    }
  }

  postAllOutCost(String projectId) async {
    try {
      emit(PostAllOutCostLoadingState());
      await Future.wait(outCost.entries.map(
          (body) => api.post(url: outCostEndPoint, isFormData: true, data: {
                'projectID': projectId,
                'amount': body.value,
                'description': body.key,
              })));
      emit(PostAllOutCostSuccessState());
    } catch (e) {
      emit(PostAllOutCostErrorState(error: e.toString()));
    }
  }

  postAllTasks(String projectId) async {
    try {
      emit(PostAllOutCostLoadingState());
      await Future.wait(tasks
          .map((body) => api.post(url: taskEndPoint, isFormData: true, data: {
                'projectID': projectId,
                'type': 'task',
                'title': body,
                'status': 'false',
              })));
      emit(PostAllTasksCostSuccessState());
    } catch (e) {
      emit(PostAllTasksErrorState(error: e.toString()));
    }
  }

  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    emit(ChangIndexState());
  }

  List<ProjectData> getFilteredStatus(String status) {
    if (status == 'الكل') return projectList;
    return projectList.where((test) => test.status == status).toList();
  }

  List<DateTime> getMarkedDates() {
    return projectList.map((project) {
      final dateParts = project.date!.split('-');
      return DateTime(
        int.parse(dateParts[0]), // السنة
        int.parse(dateParts[1]), // الشهر
        int.parse(dateParts[2]), // اليوم
      );
    }).toList();
  }

  getProgressPercent(String endDateString) {
    if (endDateString.isNotEmpty) {
      DateTime today = DateTime.now();
      DateTime endDate = DateTime.parse(endDateString);
      DateTime todayMidnight = DateTime(today.year, today.month, today.day);
      DateTime endMidnight = DateTime(endDate.year, endDate.month, endDate.day);

      Duration difference = endMidnight.difference(todayMidnight);
      int remainingDays = difference.inDays;

      return remainingDays < 0 ? 0 : remainingDays;
    } else {
      return 0;
    }
  }

  Future<void> initializeBrand() async {
    try {
      final cache = CacheHelper();
      final idBrand = cache.getData(key: 'idBrand');

      if (idBrand != null) {
        emit(GetBrandSuccessState());
        return;
      }

      final getResponse = await api.get(url: brandEndPoint);

      if (getResponse != null && getResponse['idBrand'] != null) {
        final String brandId = getResponse['idBrand'].toString();
        cache.saveData(key: 'idBrand', value: brandId);
        emit(GetBrandSuccessState());
      } else {
        await postBrand();
      }
    } catch (e) {
      emit(GetBrandErrorState(error: e.toString()));
    }
  }

  Future<void> postBrand() async {
    try {
      final postResponse = await api.post(
        url: brandEndPoint,
        data: {'name': '..'},
        isFormData: true,
      );

      final String brandId = postResponse['idBrand'].toString();
      CacheHelper().saveData(key: 'idBrand', value: brandId);

      emit(PostBrandSuccessState());
      emit(GetBrandSuccessState());
    } catch (e) {
      emit(PostBrandErrorState(error: e.toString()));
      emit(GetBrandErrorState(error: 'فشل في إنشاء العلامة التجارية'));
    }
  }
}
