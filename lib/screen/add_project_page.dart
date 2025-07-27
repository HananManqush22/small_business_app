import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/widget/custom_app_bar.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  @override
  void initState() {
    super.initState();
    ClientsCubit.get(context).getClint();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProjectCubit.get(context);
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: CustomAppBar(
              title: "انشاء مشروع",
              closeFunction: () {},
              isLoading: state is PostProjectLoadingState,
              addFunction: () async {
                if (cubit.formKey.currentState!.validate()) {
                  await cubit.postProject();
                  cubit.name.clear();
                  cubit.description.clear();
                  cubit.cost.clear();
                  cubit.date.clear();
                }
              },
            ),
          ),
          body: CustomBackground(
              item: Form(
            key: cubit.formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFiled(
                          hint: 'اسم المشروع',
                          controller: cubit.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          }),
                      BlocBuilder<ClientsCubit, ClientsState>(
                        buildWhen: (previous, current) =>
                            current is GetClientSuccessState,
                        builder: (context, state) {
                          return DropdownButtonHideUnderline(
                              child: state is GetClientSuccessState
                                  ? DropdownButton2(
                                      items: state.clientModel
                                          .map((item) => DropdownMenuItem(
                                                value: item.id.toString(),
                                                child: Text('${item.name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ))
                                          .toList(),
                                      buttonStyleData: ButtonStyleData(
                                        height: 52.h,
                                        decoration: BoxDecoration(
                                          color: fillColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                            color: fillColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        height: 30,
                                      ),
                                      isExpanded: true,
                                      disabledHint: Text(
                                        'القائمة غير متاحة',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(color: fontColor),
                                      ),
                                      hint: Text(
                                        'اختار عميل',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(color: primaryColor),
                                      ),
                                      value: cubit.clientID,
                                      onChanged: (value) {
                                        cubit.updateClientID(value.toString());
                                      },
                                    )
                                  : Container());
                        },
                      ),
                      CustomTextFiled(
                        hint: 'مذكرة',
                        maxLine: 4,
                        controller: cubit.description,
                      ),
                      Text(
                        'مهام المشروع',
                        style: (Theme.of(context).textTheme.bodyLarge ??
                                TextStyle(fontSize: 16))
                            .copyWith(color: primaryColor),
                      ),
                    ],
                  ),
                ),
                SliverList.separated(
                  itemCount: cubit.tasks.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryFont,
                          radius: 3,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          cubit.tasks[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: primaryFont),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            cubit.removeTask(index);
                          },
                          icon: Icon(
                            Icons.close,
                            color: primaryFont,
                            size: 18,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 1.h,
                    width: MediaQuery.sizeOf(context).width,
                    color: fillColor,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomTextFiled(
                        hint: 'اكتب هنا',
                        controller: cubit.task,
                      )),
                      IconButton(
                        onPressed: () {
                          if (cubit.task.text.isNotEmpty) {
                            cubit.addTask(cubit.task.text);
                            cubit.task.clear();
                          } else {
                            print('................the field is requerd');
                          }
                        },
                        icon: Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'مصروفات المشروع',
                      style: (Theme.of(context).textTheme.bodyLarge ??
                              TextStyle(fontSize: 16))
                          .copyWith(color: primaryColor),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(15),
                  sliver: SliverList.separated(
                    itemCount: cubit.outCost.length,
                    itemBuilder: (context, index) {
                      var dataOutCost = cubit.outCost.entries.toList();

                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryFont,
                            radius: 3,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            dataOutCost[index].key,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: primaryFont),
                          ),
                          const Spacer(),
                          Text(
                            dataOutCost[index].value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: primaryFont),
                          ),
                          Icon(
                            Icons.attach_money,
                            color: primaryFont,
                            size: 18,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 1.h,
                        width: MediaQuery.sizeOf(context).width,
                        color: fillColor,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    spacing: 10.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextFiled(
                            hint: 'اكتب هنا',
                            controller: cubit.outCostDescription,
                          )),
                          SizedBox(
                            width: 8.w,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: CustomTextFiled(
                              hint: '0',
                              controller: cubit.outCostValue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (cubit.outCostDescription.text.isNotEmpty &&
                                  cubit.outCostValue.text.isNotEmpty) {
                                cubit.addOutCost(cubit.outCostDescription.text,
                                    cubit.outCostValue.text);
                                cubit.outCostDescription.clear();
                                cubit.outCostValue.clear();
                              } else {
                                print(
                                    '........................the value is requerd');
                              }
                            },
                            icon: Icon(
                              Icons.check,
                              color: primaryColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      CustomTextFiled(
                          hint: 'قيمة المشروع',
                          controller: cubit.cost,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          }),
                      Row(
                        spacing: 10.w,
                        children: [
                          Expanded(
                              child: CustomTextFiled(
                            readOnly: true,
                            controller: cubit.date,
                            hint: 'موعد التسليم',
                            onTap: () async {
                              await cubit.selectDate(context);
                              if (cubit.pickerDate != null) {
                                cubit.date.text = DateFormat('yyyy-MM-dd')
                                    .format(cubit.pickerDate!);
                              }
                            },
                            isIcon: true,
                            icon: Icons.date_range_outlined,
                          )),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                items: ['يوم', 'يومين', 'اسبوع', 'اختار تاريخ']
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                buttonStyleData: ButtonStyleData(
                                  height: 52.h,
                                  decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: fillColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                  height: 30,
                                ),
                                isExpanded: true,
                                hint: Text(
                                  'موعد التذكير',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: primaryColor),
                                ),
                                value: cubit.remindDateValue,
                                onChanged: (String? value) {
                                  cubit.chooseReminderDate(value, context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        'حالة المشروع',
                        style: (Theme.of(context).textTheme.bodyLarge ??
                                TextStyle(fontSize: 16))
                            .copyWith(color: primaryColor),
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          Expanded(
                              child: CustomButtonClick(
                                  isChoose: cubit.inProgress,
                                  sizeWidth: MediaQuery.sizeOf(context).width,
                                  title: 'قيد التنفيد',
                                  onTap: () {
                                    cubit.status = 'قيد التنفيد';
                                    cubit.upDateStatus();
                                  })),
                          Expanded(
                              child: CustomButtonClick(
                                  isChoose: cubit.waiting,
                                  sizeWidth: MediaQuery.sizeOf(context).width,
                                  title: 'تحت الانتظار',
                                  onTap: () {
                                    cubit.status = 'تحت الانتظار';
                                    cubit.upDateStatus();
                                  })),
                          Expanded(
                              child: CustomButtonClick(
                                  isChoose: cubit.underReview,
                                  sizeWidth: MediaQuery.sizeOf(context).width,
                                  title: 'تحت المراجعة',
                                  onTap: () {
                                    cubit.status = 'تحت المراجعة';
                                    cubit.upDateStatus();
                                  })),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
