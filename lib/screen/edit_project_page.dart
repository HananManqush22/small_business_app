import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/widget/custom_app_bar.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class EditProjectPage extends StatefulWidget {
  const EditProjectPage(
      {super.key,
      required this.projectName,
      required this.description,
      required this.data,
      required this.cost,
      required this.reminderDate,
      required this.status,
      required this.clientId,
      required this.projectId});
  final String projectName;
  final String description;
  final String data;
  final String cost;
  final String reminderDate;
  final String status;
  final String projectId;
  final int clientId;

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  @override
  void initState() {
    var cubit = ProjectCubit.get(context);
    cubit.upDateStatus(cubit.changeStatus = widget.status);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController projectNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dataController = TextEditingController();
    TextEditingController costController = TextEditingController();
    TextEditingController reminderDateController = TextEditingController();
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        var cubit = ProjectCubit.get(context);
        return BlocConsumer<ProjectCubit, ProjectState>(
          listener: (context, state) {
            if (state is PatchProjectSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: primaryColor,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60.h),
                  child: CustomAppBar(
                      isLoading: state is PatchProjectLoadingState,
                      title: "  تعديل طلب",
                      addFunction: () async {
                        ProjectCubit.get(context).patchProject(
                            projectId: widget.projectId,
                            name: projectNameController.text.isEmpty
                                ? widget.projectName
                                : projectNameController.text,
                            date: dataController.text.isEmpty
                                ? widget.data
                                : dataController.text,
                            remendDate: reminderDateController.text.isEmpty
                                ? widget.reminderDate
                                : reminderDateController.text,
                            cost: costController.text.isEmpty
                                ? widget.cost
                                : costController.text,
                            description: descriptionController.text.isEmpty
                                ? widget.description
                                : descriptionController.text,
                            status: cubit.changeStatus,
                            clientId: widget.clientId);
                      })),
              body: CustomBackground(
                  item: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    CustomTextFiled(
                      hint: widget.projectName,
                      controller: projectNameController,
                    ),
                    CustomTextFiled(
                      hint: "${widget.data} وقت التسليم",
                      controller: dataController,
                      readOnly: true,
                      onTap: () async {
                        await cubit.selectDate(context);
                        if (cubit.pickerDate != null) {
                          dataController.text = DateFormat('yyyy-MM-dd')
                              .format(cubit.pickerDate!);
                        }
                      },
                      isIcon: true,
                      icon: Icons.date_range_outlined,
                    ),
                    CustomTextFiled(
                      hint: "${widget.reminderDate} وقت التذكير",
                      controller: reminderDateController,
                      readOnly: true,
                      onTap: () async {
                        await cubit.selectDate(context);
                        if (cubit.pickerDate != null) {
                          reminderDateController.text = DateFormat('yyyy-MM-dd')
                              .format(cubit.pickerDate!);
                        }
                      },
                      isIcon: true,
                      icon: Icons.date_range_outlined,
                    ),
                    CustomTextFiled(
                      hint: widget.cost,
                      controller: costController,
                    ),
                    CustomTextFiled(
                      hint: widget.description,
                      maxLine: 5,
                      controller: descriptionController,
                    ),
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CustomButtonClick(
                            isChoose: cubit.inProgress,
                            sizeWidth: MediaQuery.sizeOf(context).width,
                            title: 'قيد التنفيد',
                            onTap: () {
                              cubit.upDateStatus(
                                  cubit.changeStatus = 'قيد التنفيد');
                            }),
                        CustomButtonClick(
                            isChoose: cubit.waiting,
                            sizeWidth: MediaQuery.sizeOf(context).width,
                            title: 'تحت الانتظار',
                            onTap: () {
                              cubit.upDateStatus(
                                  cubit.changeStatus = 'تحت الانتظار');
                            }),
                        CustomButtonClick(
                            isChoose: cubit.underReview,
                            sizeWidth: MediaQuery.sizeOf(context).width,
                            title: 'تحت المراجعة',
                            onTap: () {
                              cubit.upDateStatus(
                                  cubit.changeStatus = 'تحت المراجعة');
                            }),
                        CustomButtonClick(
                            isChoose: cubit.done,
                            sizeWidth: MediaQuery.sizeOf(context).width,
                            title: 'مكتمل ',
                            onTap: () {
                              cubit.upDateStatus(cubit.changeStatus = 'مكتمل ');
                            }),
                        CustomButtonClick(
                            isChoose: cubit.delivery,
                            sizeWidth: MediaQuery.sizeOf(context).width,
                            title: ' ثم التسليم',
                            onTap: () {
                              cubit.upDateStatus(
                                  cubit.changeStatus = ' ثم التسليم');
                            }),
                        CustomButtonClick(
                            isChoose: cubit.cancelled,
                            sizeWidth: MediaQuery.sizeOf(context).width,
                            title: ' ثم الالغاء',
                            onTap: () {
                              cubit.upDateStatus(
                                  cubit.changeStatus = ' ثم الالغاء');
                            }),
                      ],
                    ),
                  ],
                ),
              )),
            );
          },
        );
      },
    );
  }
}
