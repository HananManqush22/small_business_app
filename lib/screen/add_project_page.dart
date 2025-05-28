import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/cubit/project_cubit/project_cubit.dart';
import 'package:small_business_app/widget/custom_app_bar.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class AddProjectPage extends StatelessWidget {
  const AddProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClientsCubit(DioConsume(dio: Dio()))..getClint(),
        ),
        BlocProvider(
          create: (context) => ProjectCubit(DioConsume(dio: Dio())),
        ),
      ],
      child: BlocConsumer<ProjectCubit, ProjectState>(
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
                    cubit.formKey.currentState!.save();
                    await cubit.postProject();
                  } else {
                    cubit.autovalidateMode = AutovalidateMode.always;
                  }
                },
              ),
            ),
            body: CustomBackground(
                item: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: cubit.formKey,
                    autovalidateMode: cubit.autovalidateMode,
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFiled(
                          hint: 'اسم المشروع',
                          onSave: (value) {
                            cubit.name = value;
                          },
                        ),
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
                                          cubit
                                              .updateClientID(value.toString());
                                        },
                                      )
                                    : Container());
                          },
                        ),
                        CustomTextFiled(
                          hint: 'مذكرة',
                          maxLine: 4,
                          onSave: (value) {
                            cubit.description = value;
                          },
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
                ),
                SliverList.separated(
                  itemCount: 2,
                  itemBuilder: (context, index) => Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryFont,
                        radius: 3,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'هذه النص تجربي لا اكثر فقط للتجربة',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: primaryFont),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          color: primaryFont,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1.h,
                    width: MediaQuery.sizeOf(context).width,
                    color: fillColor,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(child: CustomTextFiled(hint: 'اكتب هنا')),
                      IconButton(
                        onPressed: () {},
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
                    itemCount: 2,
                    itemBuilder: (context, index) => Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryFont,
                          radius: 3,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'هذه النص تجربي لا اكثر فقط للتجربة',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: primaryFont),
                        ),
                        const Spacer(),
                        Text(
                          '55',
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
                    ),
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
                          Expanded(child: CustomTextFiled(hint: 'اكتب هنا')),
                          SizedBox(
                            width: 8.w,
                          ),
                          SizedBox(
                            width: 90.w,
                            child: CustomTextFiled(
                              hint: '0',
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
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
                        onSave: (value) {
                          cubit.cost = value;
                        },
                      ),
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
                                cubit.date.text = DateFormat('dd-MM-yyyy')
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
            )),
          );
        },
      ),
    );
  }
}
