import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/core/api/dio_consume.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:small_business_app/widget/custom_app_bar.dart';
import 'package:small_business_app/widget/custom_background.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class AddProfiledPage extends StatelessWidget {
  const AddProfiledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(DioConsume(dio: Dio())),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: CustomAppBar(
                    isLoading: state is PostProfileStateLoadingState,
                    title: " اضافة ",
                    closeFunction: () {},
                    addFunction: () async {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.formKey.currentState!.save();
                        await cubit.postProfile();
                      } else {
                        cubit.autovalidateMode = AutovalidateMode.always;
                      }
                    })),
            body: CustomBackground(
              item: Form(
                key: cubit.formKey,
                autovalidateMode: cubit.autovalidateMode,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Stack(
                          children: [
                            SizedBox(
                                width: 80.w,
                                height: 80.h,
                                child: cubit.logo == null
                                    ? Image.asset(
                                        'assets/images/icon.png',
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(cubit.logo!.path)),
                                      )),
                            Positioned(
                              bottom: -12,
                              right: -15,
                              child: IconButton(
                                  onPressed: () async {
                                    await cubit.uploadProfilePic();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_sharp,
                                    color: primaryFont,
                                  )),
                            )
                          ],
                        ),
                      ),
                      CustomTextFiled(
                        hint: 'اسم البراند',
                        onSave: (value) {
                          cubit.name = value;
                        },
                      ),
                      CustomTextFiled(
                        hint: ' رقم الهاتف',
                        onSave: (value) {
                          cubit.phone = value;
                        },
                      ),
                      CustomTextFiled(
                        hint: ' حساب البراند',
                        onSave: (value) {
                          cubit.email = value;
                        },
                      ),
                      CustomTextFiled(
                        hint: ' العنوان',
                        maxLine: 2,
                        onSave: (value) {
                          cubit.address = value;
                        },
                      ),
                      CustomTextFiled(
                        hint: 'وصف البراند ',
                        maxLine: 3,
                        onSave: (value) {
                          cubit.description = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
