import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/create_user_cubit/create_user_cubit.dart';
import 'package:small_business_app/screen/sing_in_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: fillColor,
      body: BlocProvider.value(
        value: CreateUserCubit(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 70.h),
                          child: SizedBox(
                              width: 80.w,
                              height: 80.h,
                              child: Image.asset(
                                'assets/images/icon.png',
                              )),
                        ),
                        Text('تسجيل ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: primaryColor)),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFiled(
                          hint: 'اسم الحساب',
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextFiled(
                          hint: 'الايميل',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                          controller: email,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextFiled(
                          hint: 'كلمة السر',
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        BlocConsumer<CreateUserCubit, CreateUserState>(
                          listener: (context, state) {
                            if (state is UserCreateSuccessState) {
                              navigateAndReplacement(
                                  context: context, widget: SingInPage());
                            }
                          },
                          builder: (context, state) {
                            var cubit = CreateUserCubit.get(context);
                            return CustomButtonClick(
                              isLoading: state is UserCreateLoadingState,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await cubit.createUser(
                                      email: email.text,
                                      password: password.text);
                                  await cubit.sendEmailVerification();
                                }
                              },
                              title: 'تسجيل',
                              sizeWidth: MediaQuery.of(context).size.width,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
