import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/widget/custom_app_bar.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class ClientAddPage extends StatelessWidget {
  const ClientAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsCubit(DioConsume(dio: Dio())),
      child: BlocConsumer<ClientsCubit, ClientsState>(
        listener: (context, state) {
          if (state is AddClientLoadingState) {
            print('................................loding');
          } else if (state is AddClientSuccessState) {
            print('................................success');
          } else if (state is AddClientErrorState) {
            print('................................${state.error.toString()}');
          }
        },
        builder: (context, state) {
          var cubit = ClientsCubit.get(context);
          return Form(
            key: cubit.formKey,
            autovalidateMode: cubit.autovalidateMode,
            child: Scaffold(
              backgroundColor: primaryColor,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60.h),
                  child: CustomAppBar(
                      isLoading: state is AddClientLoadingState,
                      title: " اضافة عميل",
                      closeFunction: () {},
                      addFunction: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.formKey.currentState!.save();
                          await cubit.postClint();
                          cubit.name = '';
                        } else {
                          cubit.autovalidateMode = AutovalidateMode.always;
                        }
                      })),
              body: CustomBackground(
                item: Column(
                  spacing: 10,
                  children: [
                    CustomTextFiled(
                      hint: 'اسم العميل',
                      onSave: (value) {
                        cubit.name = value;
                      },
                    ),
                    CustomTextFiled(
                      hint: 'رقم الهاتف',
                      onSave: (value) {
                        cubit.phone = value;
                      },
                    ),
                    CustomTextFiled(
                      hint: 'الايميل',
                      onSave: (value) {
                        cubit.email = value;
                      },
                    ),
                    CustomTextFiled(
                      hint: 'العنوان',
                      maxLine: 2,
                      onSave: (value) {
                        cubit.address = value;
                      },
                    ),
                    CustomTextFiled(
                      hint: 'مذكرة',
                      maxLine: 3,
                      onSave: (value) {
                        cubit.description = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
