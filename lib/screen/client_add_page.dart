import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/clients_cubit/clients_cubit.dart';
import 'package:small_business_app/widget/custom_app_bar.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class ClientAddPage extends StatelessWidget {
  const ClientAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsState>(
      listener: (context, state) {
        if (state is AddClientLoadingState) {
          print('................................loding');
        } else if (state is AddClientSuccessState) {
          Navigator.pop(context);
          // navigateAndReplacement(
          //     context: context,
          //     widget: const NavigationBarPage(
          //       selectedIndex: 4,
          //     ));
        } else if (state is AddClientErrorState) {
          print('................................${state.error.toString()}');
        }
      },
      builder: (context, state) {
        var cubit = ClientsCubit.get(context);
        return Form(
          key: cubit.formKey,
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
                        await cubit.postClint();
                        cubit.name.clear();
                        cubit.phone.clear();
                        cubit.email.clear();
                        cubit.address.clear();
                        cubit.description.clear();
                      }
                    })),
            body: CustomBackground(
              item: Column(
                spacing: 10,
                children: [
                  CustomTextFiled(
                    hint: 'اسم العميل',
                    controller: cubit.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'اسم العميل مطلوب';
                      }
                      return null;
                    },
                  ),
                  CustomTextFiled(
                    hint: 'رقم الهاتف',
                    controller: cubit.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'رقم الهاتف مطلوب';
                      }
                      return null;
                    },
                  ),
                  CustomTextFiled(
                    hint: 'الايميل',
                    controller: cubit.email,
                  ),
                  CustomTextFiled(
                    hint: 'العنوان',
                    maxLine: 2,
                    controller: cubit.address,
                  ),
                  CustomTextFiled(
                    hint: 'مذكرة',
                    maxLine: 3,
                    controller: cubit.description,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
