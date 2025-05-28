import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:small_business_app/configuration/colors.dart';
import 'package:small_business_app/cubit/user_create/user_create_cubit.dart';
import 'package:small_business_app/screen/log_in_page.dart';
import 'package:small_business_app/widget/component.dart';
import 'package:small_business_app/widget/custom_button_click.dart';
import 'package:small_business_app/widget/custom_text_file.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fillColor,
      body: BlocProvider(
        create: (context) => UserCreateCubit(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: BlocConsumer<UserCreateCubit, UserCreateState>(
              listener: (context, state) {
                if (state is UserCreateSuccessState) {
                  navigateAndReplacement(context: context, widget: LoginPag());
                }
              },
              builder: (context, state) {
                return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: UserCreateCubit.get(context).formKey,
                      autovalidateMode:
                          UserCreateCubit.get(context).autovalidateMode,
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
                              onSave: (value) {
                                UserCreateCubit.get(context).email = value!;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomTextFiled(
                              hint: 'الايميل',
                              onSave: (value) {
                                UserCreateCubit.get(context).email = value!;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomTextFiled(
                              hint: 'كلمة السر',
                              onSave: (value) {
                                UserCreateCubit.get(context).password = value!;
                              },
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomButtonClick(
                              isLoading: state is UserCreateLoadingState,
                              onTap: () {
                                if (UserCreateCubit.get(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  UserCreateCubit.get(context)
                                      .formKey
                                      .currentState!
                                      .save();

                                  UserCreateCubit.get(context).createUser();
                                  UserCreateCubit.get(context)
                                      .sendEmailVerification();
                                } else {
                                  UserCreateCubit.get(context)
                                          .autovalidateMode =
                                      AutovalidateMode.always;
                                }
                              },
                              title: 'تسجيل',
                              sizeWidth: MediaQuery.of(context).size.width,
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
