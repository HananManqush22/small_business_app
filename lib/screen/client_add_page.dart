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
        } else if (state is AddClientErrorState) {
          print('................................${state.error.toString()}');
        }
      },
      builder: (context, state) {
        var cubit = ClientsCubit.get(context);
        var formKey = GlobalKey<FormState>();
        TextEditingController name = TextEditingController();
        TextEditingController email = TextEditingController();
        TextEditingController phone = TextEditingController();
        TextEditingController address = TextEditingController();
        TextEditingController description = TextEditingController();
        return Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: primaryColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: CustomAppBar(
                    isLoading: state is AddClientLoadingState,
                    title: " اضافة عميل",
                    addFunction: () async {
                      if (formKey.currentState!.validate()) {
                        await cubit.postClint(
                            name: name.text,
                            email: email.text,
                            phone: phone.text,
                            address: address.text,
                            description: description.text);
                      }
                    })),
            body: CustomBackground(
              item: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    CustomTextFiled(
                      hint: 'اسم العميل',
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'اسم العميل مطلوب';
                        }
                        return null;
                      },
                    ),
                    CustomTextFiled(
                      hint: 'رقم الهاتف',
                      controller: phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'رقم الهاتف مطلوب';
                        }
                        return null;
                      },
                    ),
                    CustomTextFiled(
                      hint: 'الايميل',
                      controller: email,
                    ),
                    CustomTextFiled(
                      hint: 'العنوان',
                      maxLine: 2,
                      controller: address,
                    ),
                    CustomTextFiled(
                      hint: 'مذكرة',
                      maxLine: 3,
                      controller: description,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
