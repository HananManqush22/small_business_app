import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/cubit/project_expenses_cubit/project_expenses_cubit.dart';
import 'package:small_business_app/models/out_cost_model.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_separator_line.dart';
import 'package:small_business_app/widget/custom_text_file.dart';
import 'package:small_business_app/widget/expenses_item.dart';

class ProjectExpensesPage extends StatelessWidget {
  const ProjectExpensesPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    TextEditingController cost = TextEditingController();
    TextEditingController description = TextEditingController();
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return BlocProvider.value(
      value: ProjectExpensesCubit(DioConsume(dio: Dio()))..getOutCost(id),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(
            child: Text(
              'مصروفات المشروع',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: backgroundColor),
            ),
          ),
        ),
        body: CustomBackground(
            item: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: BlocBuilder<ProjectExpensesCubit, ProjectExpensesState>(
                builder: (context, state) => SliverList.separated(
                  itemCount: ProjectExpensesCubit.get(context).outCos.length,
                  itemBuilder: (context, index) {
                    if (state is GitOutCostSuccessState) {
                      Data outCost =
                          ProjectExpensesCubit.get(context).outCos[index];
                      return ExpensesItem(
                        title: '${outCost.description}',
                        cost: '${outCost.amount}',
                      );
                    }
                    return Container();
                  },
                  separatorBuilder: (context, index) => CustomSeparatorLine(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Form(
                key: key,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFiled(
                      hint: 'اكتب هنا',
                      controller: description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                    )),
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: CustomTextFiled(
                        controller: cost,
                        hint: '0',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocBuilder<ProjectExpensesCubit, ProjectExpensesState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              await ProjectExpensesCubit.get(context)
                                  .postOutCost(
                                      projectId: '$id',
                                      amount: cost.text,
                                      description: description.text);
                              cost.clear();
                              description.clear();
                            }
                          },
                          icon: Icon(
                            Icons.check,
                            color: primaryColor,
                            size: 25,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
